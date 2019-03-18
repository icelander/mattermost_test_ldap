# Mattermost Test LDAP Server

This sets up a Mattermost server and connects it to Rafael Römhild's great [OpenLDAP Docker Image for testing](https://github.com/rroemhild/docker-test-openldap).

## Server Setup

1. Install license file in this directory, named `license.txt`
2. Run `vagrant up`
3. Go to `http://127.0.0.1` and log in with `admin/admin` or `professor/professor`

For more logins, check the LDAP server's documentation.

## Scripts

### ldap-check.sh

This is cloned from [the Mattermost server scripts](https://github.com/mattermost/mattermost-server/blob/master/scripts/ldap-check.sh) and reads your Mattermost config and generates and run an `ldapsearch` command to test your settings.

0. Install the `ldapsearch` binary on your system
1. `sudo mv /vagrant/ldap-check.sh /opt/mattermost/ldap-check.sh`
2. `cd /opt/mattermost`
3. `sudo chmod +x ldap-check.sh`
4. `./ldap-check.sh user@example.com`

### update.sh

This uses the `ldapmodify` command to make changes to the LDAP server to ensure they're synced to Mattermost. Example LDIF files are available in the `ldifs` directory.

0. Install the `ldapmodify` on your system
1. `/vagrant/update.sh`