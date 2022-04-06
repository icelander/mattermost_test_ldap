#!/bin/bash

apt-get -qq -y update
apt-get install -y -q postgresql-client ldapscripts jq haproxy

# Install haproxy config
mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.orig.cfg
cp /vagrant/haproxy.cfg /etc/haproxy/haproxy.cfg
service haproxy restart