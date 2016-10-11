#!/bin/sh

    sudo hostnamectl set-hostname puppet.awezone.com
    sudo apt-get update
    sudo apt-get -y install ca-certificates
    wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
    sudo dpkg -i puppetlabs-release-trusty.deb
    sudo sh -c 'echo "deb http://deb.theforeman.org/ trusty 1.5" > /etc/apt/sources.list.d/foreman.list'
    sudo sh -c 'echo "deb http://deb.theforeman.org/ plugins 1.5" >> /etc/apt/sources.list.d/foreman.list'
    sudo wget -q http://deb.theforeman.org/pubkey.gpg -O- | sudo apt-key add -
    sudo apt-get update
    #sudo apt-get -yq install puppet=3.7.4-1puppetlabs1 puppet-common=3.7.4-1puppetlabs1
    sudo apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -yq install puppet=3.7.4-1puppetlabs1 puppet-common=3.7.4-1puppetlabs1
    sudo apt-get -f install foreman-installer -y
    sudo foreman-installer