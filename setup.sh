#!/bin/bash

apt-get -qq -y update
apt-get -qq -y upgrade

export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password #MYSQL_ROOT_PASSWORD#'
debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password #MYSQL_ROOT_PASSWORD#'
apt-get install -y -q mariadb-server

sed -i 's/MATTERMOST_PASSWORD/#MATTERMOST_PASSWORD/' /vagrant/db_setup.sql
echo "Setting up database"
mysql -uroot -p#MYSQL_ROOT_PASSWORD < /vagrant/db_setup.sql

rm -rf /opt/mattermost

wget --quiet https://releases.mattermost.com/5.1.0/mattermost-5.1.0-linux-amd64.tar.gz

tar -xzf mattermost*.gz

rm mattermost*.gz
mv mattermost /opt

mkdir /opt/mattermost/data

useradd --system --user-group mattermost
chown -R mattermost:mattermost /opt/mattermost

chmod -R g+w /opt/mattermost

# "mmuser:mostest@tcp(dockerhost:3306)/mattermost_test?charset=utf8mb4,utf8&readTimeout=30s&writeTimeout=30s",
sed -i -e 's/dockerhost:3306/127.0.0.1:3306/g' /opt/mattermost/config/config.json
sed -i -e 's/mostest/#MATTERMOST_PASSWORD/g' /opt/mattermost/config/config.json
sed -i -e 's/mattermost_test/mattermost/g' /opt/mattermost/config/config.json

cp /vagrant/mattermost.service /lib/systemd/system/mattermost.service
systemctl daemon-reload

service mysql start
service mattermost start