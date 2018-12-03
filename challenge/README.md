# Security Challenge

The challenge consists of:

<li>Building your cluster from scratch with HDFS, YARN, Hive and Sentry</li>
<li>Setup your OS with OpenLDAP, SSSD, and MIT Kerberos</li>
<li>Enable LDAP and Kerberos Authentication</li>
<li>Enable Sentry Authorization</li>
<li>Setup TLS for Cloudera Manager Web UI and Agents (Levels 1 through 3)</li>

<br/>

You will have only 4 hours to complete the work. Please submit the following evidence:

<li>Output from 'id user1' and 'getent group managers'</li>
<li>Output from 'kinit admin' and 'klist' after successful kinit authentication</li>
<li>Screenshot from logging into CM as 'user1' (should show CM using https on 7183, no administrator capabilities enabled, all green/orange)</li>
<li>Output from steps used to create a table in the default database where ONLY managers can read its contents, but analysts cannot</li>

<br/>

Please submit all your evidence <a href="config">here</a>
