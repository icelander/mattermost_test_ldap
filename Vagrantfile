# -*- mode: ruby -*-
# vi: set ft=ruby :

MATTERMOST_VERSION = "6.5.0"

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
  end

  config.vm.network "private_network", ip: "192.168.1.100"

  config.vm.provision :shell, path: 'haproxy.sh'

  config.vm.provision :shell, inline: 'tar -xzf /vagrant/ldifs.tgz -C /tmp'

  config.vm.provision :docker, run: 'once'
  config.vm.provision :docker_compose, yml: "/vagrant/docker-compose.yml"
  
  # Wait 30 seconds for PostgreSQL to come up
  sleep 30
  
  config.vm.provision :shell,
      path: "mattermost.sh",
      args: [MATTERMOST_VERSION],
      run: 'once'

end