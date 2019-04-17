# Mattermost Test LDAP Server

This sets up a Mattermost server and connects it to Rafael Römhild's great [OpenLDAP Docker Image for testing](https://github.com/rroemhild/docker-test-openldap).

## Server Setup

1. Install license file in this directory, named `license.txt`
2. Run `vagrant up`
3. Go to `http://127.0.0.1` and log in with `admin/admin`
4. Configure the Planet Express Team to Open Invite by going to `Main Menu` > `Team Settings` > `Allow any user with an account on this server to join`. This is required because there is no way to add all Mattermost users to a default team.
5. In a separate browser window, log in with the following LDAP usernames (passwords are identical):

 - fry - on Ship's Crew team and Planet Express
 - hermes - on Administrator's team and Planet Express
 - bender - Ship's Crew/Planet Express
 - zoidberg - Only Planet Express

Notice how janky it is and how you have to click way to goddamn much to get to a place where you can see the teams

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