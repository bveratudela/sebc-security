# Certificate Scripts

The following scripts are provided to help simulate the certificate generation process. However, we do not have a Certificate Authority to issue signed certificates. In its absence, we will create our own root and intermediate CAs using the following scripts (but first make sure your clustervars file is edited with your cluster details):

```
./2-CreateRootCA.sh
./3-CreateIntermediateCA.sh
```

Once you have your root and intermediate CAs created, you need to generate your Certificate Signing Requests (CSRs) along with its corresponding Private Key FOR EACH HOST. Remember your certificates have pre-requisites that must be met. These are included in the certificates during the CSR process. To get the CSRs created and certificates signed:

```
./4-GenerateCSRnKey.sh <FQDN>
```

This will create a CSR and a Private Key file named <host>.csr and <host>.key. The CSR is what you provide to your CA to issue signed certificates but since we are managing the CA, we will emulate this process:

```
./5-SignCert.sh <FQDN>
```

You will now have a signed certificate named <host>.pem. To verify that the certificate and key match, ensure that the following both output the same MD5 checksum:

```
openssl x509 -modulus -in <host>.pem -noout | openssl md5
openssl rsa  -modulus -in <host>.key -noout | openssl md5
```

This process so far has create x509 (PEM) format certificates which can be used by non-Java applications. However, Java applications require a Java KeyStore (JKS) format. In Cloudera, we have a combination of Java and non-Java based components. To create the JKS format of the certificates:

```
./6-CreateKeystore.sh <FQDN>
./7-CreateKeystore.sh
```

Once the process is completed, you will require the following files:

<li>Root CA certificate: rootca.pem and truststore.jks</li>
<li>Intermediate CA certificate: intermediateca.pem and truststore.jks</li>
<li>Each host certificate: <host>.pem and <host>.jks</li>
<li>Each host private key: <host>.key (key for JKS is included in the <host>.jks)</li>

<br/>

You may inspect the contents of each certificate via the following command:

```
PEM: openssl x509 -in <host>.pem -text -noout
JKS: keytool -keystore <host>.jks -storepass <password> -list -v
```

Please submit the output from this command on at least one certificate and publish it <a href="output.txt">here</a>
