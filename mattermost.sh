#!/bin/bash

mattermost_version=$1

rm -rf /opt/mattermost

archive_filename="mattermost-$mattermost_version-linux-amd64.tar.gz"
archive_path="/vagrant/mattermost_archives/$archive_filename"
archive_url="https://releases.mattermost.com/$mattermost_version/$archive_filename"

if [[ ! -d /vagrant/mattermost_archives ]]; then
	mkdir -p /vagrant/mattermost_archives
fi

if [[ ! -f $archive_path ]]; then
	wget --quiet $archive_url -O $archive_path
fi

if [[ ! -f $archive_path ]]; then
	echo "Could not find archive file, aborting"
	echo "Path: $archive_path"
	exit 1
fi

cp $archive_path ./

tar -xzf mattermost*.gz

rm mattermost*.gz
mv mattermost /opt

mkdir /opt/mattermost/data

mv /opt/mattermost/config/config.json /opt/mattermost/config/config.orig.json
jq -s '.[0] * .[1]' /opt/mattermost/config/config.orig.json /vagrant/config.json > /opt/mattermost/config/config.json

useradd --system --user-group mattermost
chown -R mattermost:mattermost /opt/mattermost
chmod -R g+w /opt/mattermost

cp /vagrant/mattermost.service /lib/systemd/system/mattermost.service
systemctl daemon-reload

cd /opt/mattermost
chown -R mattermost:mattermost /opt/mattermost

service mattermost start

if [[ -f /vagrant/e20license.txt ]]; then
	echo "Installing E20 License"
	runuser -l mattermost -c '/opt/mattermost/bin/mmctl --local license upload /vagrant/e20license.txt'
fi

runuser -l mattermost -c '/opt/mattermost/bin/mmctl --local user create --email admin@planex.com --username admin --password admin --system-admin'
runuser -l mattermost -c '/opt/mattermost/bin/mmctl --local team create --name "planex" --display-name "Planet Express"'
runuser -l mattermost -c '/opt/mattermost/bin/mmctl --local team users add planex admin'

printf '=%.0s' {1..80}
echo 
echo '                     VAGRANT UP!'
echo "GO TO http://mattermost.planex.com and log in with \`admin\`"
echo
printf '=%.0s' {1..80}
