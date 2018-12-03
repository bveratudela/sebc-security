# Certificate Scripts

The following scripts are provided to help simulate the certificate generation process. However, we do not have a Certificate Authority to issue signed certificates. In its absence, we will create our own root and intermediate CAs using the following scripts (but first make sure your cluster.txt and clustervars files are edited with your cluster details):

```
./2-RootCA.sh
./3-IntermediateCA.sh
```

Once you have your root and intermediate CAs created, you need to generate your Certificate Signing Requests (CSRs) along with their corresponding Private Keys. Remember your certificates have pre-requisites that must be met. These are included in the certificates during the CSR process. To get the CSRs created and certificates signed:

```
./4-SignedCerts.sh
```

The process above will create x509 (PEM) format certificates which can be used by non-Java applications. However, Java applications require a Java KeyStore (JKS) format. In Cloudera, we have a combination of Java and non-Java based components. To create the JKS format of the certificates:

```
./5-CreateKeystore.sh
```

Once the process is completed, you will have the following files:

<li>Root CA certificate: rootca.pem and truststore.jks</li>
<li>Intermediate CA certificate: intermediateca.pem and truststore.jks</li>
<li>Each host certificate: <host>.pem and <host>.jks</li>
<li>Each host private key: <host>.key (key for JKS is included in the <host>.jks)</li>

You may inspect the contents of each certificate via the following command:

```
PEM: openssl x509 -in <host>.pem -text -noout
JKS: keytool -keystore <host>.jks -storepass <password> -list -v
```

Please submit the output from this command on at least one certificate and publish it <a href="output.txt">here</a>
