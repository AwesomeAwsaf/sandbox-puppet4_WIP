#!/bin/sh

# Run on VM to bootstrap Puppet Master server
if 
 ps aux | grep "puppet master" | grep -v grep 2> /dev/null
 then
    echo "Puppet Master is already installed. Exiting..."
     sudo puppet resource package puppetmaster ensure=latest &&
     #sudo puppet master --verbose --no-daemonize
	 sudo puppet agent --enable 
     sudo puppet agent --test
     sudo puppet module install -f chocolatey-chocolatey  --target-dir /vagrant/modules

 else
    echo "Puppet Master should have been installed using the puppet provisioner"
fi
    echo "apt-get update & foreman install"


    