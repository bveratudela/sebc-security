#!/bin/sh

source ./clustervars

CN=$1

cp ca/intermediate/openssl.cnf .
cat >> openssl.cnf << EOF
[alt_names]
DNS.1 = ${CN}
EOF

openssl req -config openssl.cnf -reqexts server_cert -new -newkey rsa:2048 -sha256 -keyout ${CN}.key -out ${CN}.csr -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGNAME}/OU=${ORGUNIT}/CN=${CN}" -passin pass:${PASSWORD} -passout pass:${PASSWORD}
