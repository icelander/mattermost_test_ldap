# -*- mode: ruby -*-
# vi: set ft=ruby :

MYSQL_ROOT_PASSWORD = 'mysql_root_password'
MATTERMOST_PASSWORD = 'really_secure_password'

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network "forwarded_port", guest: 8065, host: 8065, host_ip: "127.0.0.1"
  config.vm.hostname = 'mattermost'

  setup_script = File.read('setup.sh')

  setup_script.gsub!('#MATTERMOST_PASSWORD', MATTERMOST_PASSWORD)
  setup_script.gsub!('#MYSQL_ROOT_PASSWORD', MYSQL_ROOT_PASSWORD)
 
  config.vm.provision :shell, inline: setup_script, run: 'once'
end
