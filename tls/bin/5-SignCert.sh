#!/bin/sh

source ./clustervars

CN=$1

# Create signed cert with intermediate CA and server_cert extensions (which include serverAuth and clientAuth for multiple use and TLS3)
openssl ca -config openssl.cnf -extensions server_cert -days 365 -notext -md sha256 -in ${CN}.csr -out ${CN}.pem -batch

chmod 400 ${CN}.key
chmod 444 ${CN}.pem
