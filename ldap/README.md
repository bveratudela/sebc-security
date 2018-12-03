# Setting up LDAP

Now you will setup LDAP authentication which is used for the following components:

<li>Cloudera Manager</li>
<li>Cloudera Navigator</li>
<li>HUE</li>
<li>Optional: Other components allow LDAP authentication along or in lieu of Kerberos: Impala, Hive, etc.</li>

When configuring LDAP for Cloudera Manager, keep in mind the following concepts:

<li>LDAP URL: Takes the form ldap[s]://<LDAP_SERVER>:<PORT> where ldaps is used for secure LDAP connections</li>
<li>LDAP Bind User Distinguished Name: User allowed to search the directory for users and groups</li>
<li>LDAP Bind Password: Password for the Bind User</li>
<li>LDAP User Search Base: Tree within the directory to search for users</li>
<li>LDAP User Search Filter: Filter used to search for users</li>
<li>LDAP Group Search Base: Tree within the directory to search for groups</li>
<li>LDAP Group Search Filter: Filter used to search for groups</li>

Please note that the use of ldaps is EXTREMELY IMPORTANT as otherwise users would be authenticated passing their credentials in clear text over the network! Anyone intercepting traffic would get immediate access to private credentials!

For this bootcamp, your job is to configure LDAP authentication ONLY for Cloudera Manager. If you setup OpenLDAP following the OS setup, use the following values:

LDAP URL: ldap://<LDAP_SERVER>
LDAP Bind User Distinguished Name: cn=admin,dc=sebc,dc=org
LDAP Bind User Password: passw0rd
LDAP User Search Base: ou=people,dc=sebc,dc=org
LDAP User Search Filter: (uid={0})
LDAP Group Search Base: ou=groups,dc=sebc,dc=org
LDAP Group Search Fiter: (memberUid={0})

You will need to set <b>Authentication Backend Order</b> to <b>External then Database</b> (this prevents you from getting locked out if the LDAP configuration does not work) and <b>External Authentication Type</b> to <b>LDAP</b>. Also make the 'admins' group be the <b>LDAP Full Administrator Groups</b>. You will need to restart the Cloudera Manager server via the following command:

```
service cloudera-scm-server restart
```

Test your configuration by logging into Cloudera Manager using the admin:passw0rd credentials. Take a screenshot and show that you are logged into Cloudera Manager as an admin user (member of the Full Administrator Group).
