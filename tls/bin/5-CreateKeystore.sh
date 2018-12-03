#!/bin/sh

source ./clustervars

JAVA_SEC_LIB=$JAVA_HOME/jre/lib/security/
PATH=$JAVA_HOME/bin:$PATH

for i in $(cat cluster.txt)
do
    CN=${i}
    openssl pkcs12 -export -inkey ${i}.key -in ${i}.pem -passin pass:${PASSWORD} -out ${i}.p12 -passout pass:${PASSWORD} -name ${CN}
    keytool -importkeystore -alias ${CN} -srckeystore ${i}.p12 -srcstoretype PKCS12 -srcstorepass ${PASSWORD} -destkeystore ${i}.jks -deststoretype JKS -deststorepass ${PASSWORD}
done

cp $JAVA_SEC_LIB/cacerts ./jssecacerts

keytool -import -trustcacerts -keystore jssecacerts -alias rootca -storepass changeit -file rootca.pem -noprompt
keytool -importcert -keystore truststore.jks -alias rootca -file rootca.pem -storepass ${PASSWORD} -noprompt
~
