#!/bin/sh

sudo cp /vagrant/testdata/puppet.conf /etc/puppet/puppet.conf
sudo service puppet restart
sudo service apache2 restart
sleep 15s
sudo puppet agent -t