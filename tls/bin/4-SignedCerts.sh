#!/bin/sh

source ./clustervars

echo ${PASSWORD} > pkey.pass
chmod 400 pkey.pass

for i in $(cat cluster.txt)
do
    CN=${i}
    ENTRY=2
    cp ca/intermediate/openssl.cnf .
    cat >> openssl.cnf << EOF
[alt_names]
DNS.1 = ${CN}
EOF

    openssl req -config openssl.cnf -reqexts server_cert -new -newkey rsa:2048 -sha256 -keyout ${i}.key -out ${i}.csr -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGNAME}/OU=${ORGUNIT}/CN=${CN}" -passin pass:${PASSWORD} -passout pass:${PASSWORD}

#   Create signed cert with intermediate CA and server_cert extensions (which include serverAuth and clientAuth for multiple use and TLS3)
    openssl ca -config openssl.cnf -extensions server_cert -days 365 -notext -md sha256 -in ${i}.csr -out ${i}.pem -batch

    chmod 400 ${i}.key
    chmod 444 ${i}.pem
done
