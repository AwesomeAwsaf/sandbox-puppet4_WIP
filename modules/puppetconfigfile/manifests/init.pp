## Update Puppet.conf on Agent Nodes

class puppetconfigfile {

  file { 'puppet.conf':
    path   => '/etc/puppet/puppet.conf',
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0644',
    source => 'puppet:///modules/puppetconfigfile/puppet.conf',
    notify => Service[ 'puppetagent' ],
  }
  # required to start client agent on ubuntu
  exec { 'start_puppet':
    command => '/bin/sed -i /etc/default/puppet -e "s/START=no/START=yes/"',
    onlyif  => '/usr/bin/test -f /etc/default/puppet',
    before  => Service[ 'puppet' ],
  }

  service { 'puppetagent':
    ensure  => running,
    name    => 'puppet',
    enable  => true,
    #require => Exec['start_puppet']
  }
}
