# Replicating MM-11525

## Quickstart

0. Install [Virtualbox] and [Vagrant]
1. run `vagrant up` from this directory
2. Go to [your new server] Log in with the username and password `zoidberg`, then
3. `vagrant ssh` into the test server and run `/vagrant/update_zoidberg.sh` which changes the users's email address from `zoidberg@planetexpress.com` to `Zoidberg@planetexpress.com` using `update.ldif`
4. Go back to [your new server] and notice you get logged out
5. run `tail /opt/mattermost/logs/mattermost.log` on the test server to see this entry:

```
{"level":"info","ts":1534892683.6643157,"caller":"ldap/ldap_sync_job.go:261","msg":"Mattermost user was deactivated by LDAP server","workername":"EnterpriseLdapSync","user_id":"fxchot438pb15es918txxgzpoc","user_username":"zoidberg","user_email":"zoidberg@planetexpress.com"}
```

## Downloads

[Virtualbox]: https://www.virtualbox.org/wiki/Downloads
[Vagrant]: https://www.vagrantup.com/downloads.html
[your new server]: http://localhost:8065