# -*- mode: ruby -*-
# vi: set ft=ruby :

MYSQL_ROOT_PASSWORD = 'mysql_root_password'
MATTERMOST_PASSWORD = 'really_secure_password'

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network "public_network"
  config.vm.hostname = 'mattermost'

  setup_script = File.read('setup.sh')

  setup_script.gsub!('#MATTERMOST_PASSWORD', MATTERMOST_PASSWORD)
  setup_script.gsub!('#MYSQL_ROOT_PASSWORD', MYSQL_ROOT_PASSWORD)
 
  config.vm.provision :shell, inline: setup_script, run: 'once'
  
end
