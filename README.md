# Replicating 

## Quickstart

0. Install [Virtualbox] and [Vagrant]
1. run `vagrant up` from this directory
2. Go to [your new server] Try to log in with the username and password `leela`, then log out and log in with the username and password `admin`
3. Add the user Leela to the Planet Express team
4. Wonder why we don't make the only team the default team for LDAP users.
5. Log out and log in with the username/password `leela`
3. `vagrant ssh` into the test server and run `/vagrant/update_leela.sh` which changes the users's `sn` field from `Leela` to `Leela-Fry` using `ldifs/change_surname.ldif`
4. Go back to [your new server] and notice you get logged out
5. run `tail /opt/mattermost/logs/mattermost.log` on the test server to see this entry:

```
{"level":"info","ts":1534892683.6643157,"caller":"ldap/ldap_sync_job.go:261","msg":"Mattermost user was deactivated by LDAP server","workername":"EnterpriseLdapSync","user_id":"fxchot438pb15es918txxgzpoc","user_username":"zoidberg","user_email":"zoidberg@planetexpress.com"}
```

[Virtualbox]: https://www.virtualbox.org/wiki/Downloads
[Vagrant]: https://www.vagrantup.com/downloads.html
[your new server]: http://localhost:8065

## Important!

*When you're done testing make sure to run `vagrant halt` to stop the server. To delete it entirely, run `vagrant destroy`*