# Mattermost Test LDAP server

This will set up a Mattermost server with a pre-populated LDAP server, LDAP admin, and Mailhog for email debugging.

## Setup

1. Copyt the Mattermost license file in this directory and name it `e20license.txt`
2. Edit the Vagrantfile to ensure the IP address of the server does not conflict with other devices on your network
3. Edit your `hosts` file or DNS server to point `http://mattermost.planex.com` to the IP address of the Vagrant machine
4. Run `vagrant up`
5. Go to `http://mattermost.planex.com` and log in with `admin/admin`
6. Configure the Planet Express Team to Open Invite by going to `Main Menu` > `Team Settings` > `Allow any user with an account on this server to join`. This is required because there is no way to add all Mattermost users to a default team.

## Connecting to the Server

### Hosts

Add the following hosts to your `hosts` file or DNS:

 - `mail.planex.com`
 - `mattermost.planex.com`
 - `ldapadmin.planex.com`

### SSH

 - `vagrant ssh`

### PostgreSQL

 - Configure your local client like this:
 	- **Host:** `127.0.0.1`
 	- **Username:** `mmuser`
 	- **Password:** `really_secure_password`
 	- **Database:** `mattermost`
 	- **Port:** `5432`

### LDAP Admin

To connect to the LDAP Admin system, first edit hour `hosts` file or DNS server to point `http://ldapadmin.planex.com`. Then, visit that site in your web browser and log in with these credentials:

 - `cn=admin,dc=planetexpress,dc=com`
 - `GoodNewsEveryone`

### Mailhog

Go to `http://mail.planex.com` and you should see the Mailhog interface

## Version History

### 0.2.0 - This release

 - **Added** More LDAP users and groups
 - **Added** LDAP Administration
 - **Added** Added Mailhog for email debugging
 - **Improved** Now using docker-compose for everything but Mattermost
 - **Improved** Now using Mattermost v6.5
 - **Changed** Using `mmctl` for server setup
 - **Changed** Using PostgreSQL

### 0.1.0

 - **Added** LDAP Group Sync
 - **Added** Local Database connection
 - **Improved** Now using a much smaller config file and using `jq` to merge it with the version's config file.
 - **Improved** To specify the Mattermost version, set it in the Vagrantfile. It will download that version if it doesn't exist.

### 0.0.1