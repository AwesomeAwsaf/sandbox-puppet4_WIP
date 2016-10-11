#!/bin/sh

# Run on VM to bootstrap Puppet Agent nodes

if ps aux | grep "puppet agent" | grep -v grep 2> /dev/null;
then echo "Puppet Agent is already installed. Moving on..."
     sudo puppet resource cron puppet-agent ensure=present user=root minute=30 command='/usr/bin/puppet agent --onetime --no-daemonize --splay'
     sudo puppet resource service puppet ensure=running enable=true
     sudo puppet agent --enable 
     sudo puppet agent --test
else
    echo "Puppet Agent should have been installed using the puppet provisioner, installing now by shell"
    #if cat /etc/ | grep "CentOS" | grep -v grep 2> /dev/null ;
    #then sudo yum install puppet && sudo puppet resource package puppet ensure=latest && sudo /etc/init.d/puppet restart
    #else echo "Puppet Agent could not be installed because unidentifiable OS"
    #fi 

    #if cat /etc/ | grep "Ubuntu" | grep -v grep 2> /dev/null ; 
    #then sudo apt-get install -yq puppet
    #else echo "Puppet Agent could not be installed because unidentifiable OS"
    #fi
fi

if cat /etc/crontab | grep puppet 2> /dev/null
then
    echo "Puppet Agent is already configured. Exiting..."
else
    echo "The CRON JOB should have been updated by the Pupper provisioner, doing it now"

    sudo puppet resource cron puppet-agent ensure=present user=root minute=30 \
        command='/usr/bin/puppet agent --onetime --no-daemonize --splay'

    #sudo puppet resource service puppet ensure=running enable=true
fi
