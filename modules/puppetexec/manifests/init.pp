## Update Puppet.conf on Agent Nodes

class puppetexec {

  # required to start client agent on ubuntu
  exec { 'start_puppet':
    command => '/bin/sed -i /etc/default/puppet -e "s/START=no/START=yes/"',
    onlyif  => '/usr/bin/test -f /etc/default/puppet',
    #before  => Service[ 'puppet' ],
  }

}
