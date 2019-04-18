# Mattermost Test LDAP Server

This sets up a Mattermost server and connects it to Rafael Römhild's great [OpenLDAP Docker Image for testing](https://github.com/rroemhild/docker-test-openldap).

## Server Setup

1. Install license file in this directory, named `e20license.txt`
2. Run `vagrant up`
3. Go to `http://127.0.0.1` and log in with `admin/admin`
4. Configure the Planet Express Team to Open Invite by going to `Main Menu` > `Team Settings` > `Allow any user with an account on this server to join`. This is required because there is no way to add all Mattermost users to a default team.
5. In a separate browser window, log in with the following LDAP usernames (passwords are identical):

 - `fry` - on Ship's Crew team and Planet Express
 - `hermes` - on Administrator's team and Planet Express
 - `bender` - Ship's Crew/Planet Express
 - `zoidberg` - Only Planet Express

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


### Connecting to the server

### SSH

 - `vagrant ssh`

### MySQL

 - Configure your local client like this:
 	- **Host:** `127.0.0.1`
 	- **Username:** `mmuser`
 	- **Password:** `really_secure_password`
 	- **Database:** `mattermost`
 	- **Port:** `13306`

## Version History

0.1.0 - This release

 - **Added** LDAP Group Sync
 - **Added** Local Database connection
 - **Improved** Now using a much smaller config file and using `jq` to merge it with the version's config file.
 - **Improved** To specify the Mattermost version, set it in the Vagrantfile. It will download that version if it doesn't exist.

0.0.1 - Intial release