# Replicating Surname Change Issue

## Steps to Reproduce

0. Install [Virtualbox] and [Vagrant]
1. run `vagrant up` from this directory
2. Go to [your new server] Try to log in with the username and password `fry`, then log out and log in with the username and password `admin`
3. Add the user `fry` to the Planet Express team
4. Wonder why we don't make the only team the default team for LDAP users.
5. Log out and log in with the username/password `fry`
3. `vagrant ssh` into the test server and run `/vagrant/update_leela.sh` which changes the fields to replicate the changes made by the user.
4. Go back to [your new server] and notice you get logged out

[Virtualbox]: https://www.virtualbox.org/wiki/Downloads
[Vagrant]: https://www.vagrantup.com/downloads.html
[your new server]: http://localhost:8065

## Important!

*When you're done testing make sure to run `vagrant halt` to stop the server. To delete it entirely, run `vagrant destroy`*