#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo" 
   exit 1
fi

mattermost_install_dir='/opt/mattermost'
upgrade_version='5.10.0' # TODO: Make this self-updating

cd /opt # perform this in the opt directory

echo "Backing up current installation"
cp -ra mattermost/ mattermost-backup-$(date +'%F-%H-%M')/

echo "Downloading latest version if it doesn't exist"
tar_file="mattermost-$upgrade_version-linux-amd64.tar.gz"
if [[ ! -f ./$tar_file ]]; then
	echo "Downloading Mattermost"
	wget https://releases.mattermost.com/$upgrade_version/mattermost-$upgrade_version-linux-amd64.tar.gz
fi

echo "Extracting new version to /opt/mattermost-$upgrade_version"
mkdir mattermost-$upgrade_version
tar -xzf ./$tar_file --directory ./mattermost-$upgrade_version/ --strip-components 1

echo "Go into that directory"
cd mattermost-$upgrade_version

echo "Migrating Configuration"
mv config/config.json config/config.original.json
cp $mattermost_install_dir/config/config.json config/config.json

echo "Migrating Logs"
if [[ -f logs/mattermost.log ]]; then
	mv logs/mattermost.log logs/mattermost.original.log
fi
cp -rf $mattermost_install_dir/logs/* logs/

echo "Migrating Plugins"

if [[ -f plugins ]]; then
	mv plugins plugins.original	
fi
cp -rf $mattermost_install_dir/plugins ./

if [[ -f client/plugins ]]; then
	mv client/plugins client/plugins.original	
fi
cp -rf $mattermost_install_dir/plugins ./client/

echo "Migrating Data"

if [[ -f data ]]; then
	mv data data.original	
fi

cp -rf $mattermost_install_dir/data ./

echo "Verify ownership of /opt/mattermost-$upgrade_version"
chown -R mattermost:mattermost /opt/mattermost-$upgrade_version

echo "Stop Mattermost"
service mattermost stop

echo "Remove original installation"
rm -rf $mattermost_install_dir

echo "Switch to using a symlink"
ln -s /opt/mattermost-$upgrade_version $mattermost_install_dir

echo "Verify ownership of $mattermost_install_dir"
chown -R mattermost:mattermost $mattermost_install_dir

echo "Start Mattermost"
service mattermost start