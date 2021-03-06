# == Class: puppet::server
#
# This class installs and manages the Puppet server daemon.
#
# === Parameters
#
# [*ensure*]
#   What state the package should be in. Defaults to +latest+. Valid values are
#   +present+ (also called +installed+), +absent+, +purged+, +held+, +latest+,
#   or a specific version number.
#
# [*package_name*]
#   The name of the package on the relevant distribution. Default is set by
#   Class['puppet::params'].
#
# === Actions
#
# - Install Puppet server package
# - Install puppet-lint gem
# - Configure Puppet to autosign puppet client certificate requests
# - Configure Puppet to use nodes.pp and modules from /vagrant directory
# - Ensure puppet-master daemon is running
#
# === Requires
#
# === Sample Usage
#
#   class { 'puppet::server': }
#
#   class { 'puppet::server':
#     ensure => 'puppet-2.7.17-1.el6',
#   }
#
class puppet::server(
  $ensure       = $puppet::params::server_ensure,
  $package_name = $puppet::params::server_package_name,
  $servicename  = $puppet::params::server_service_name
) inherits puppet::params {

  # required to prevent syslog error on ubuntu
  # https://bugs.launchpad.net/ubuntu/+source/puppet/+bug/564861
  file { [ '/etc/puppetlabs/puppet', '/etc/puppetlabs/puppet/files', '/etc/puppetlabs', '/etc/puppetlabs/code', '/etc/puppetlabs/code/manifests' ]:
    ensure => directory,
    before => Package[ 'puppetserver' ],
  }

  package { 'puppetserver':
    #ensure  => $ensure,
    ensure  => installed,
    #name    => $package_name,
    #name    => puppetserver,
    #require => Exec[ 'serverupdate' ],
    #notify  => Exec[ 'restart_puppetserver'],
  }
  package { 'puppetmaster':
    ensure  => absent,
    #name    => puppetmaster,
  }
  
  #exec { 'restart_puppetserver':
  #  command => '/usr/bin/sudo service /opt/puppetlabs/bin/puppetserver restart',
  #  notify  => Exec[ 'start_puppetserver'],
  #}
#
  #exec { 'start_puppetserver':
  #  command => '/usr/bin/sudo /opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true',
  #  require => Package[ 'puppetmaster' ],
  #  #before  => Service[ 'puppetmaster' ],
  #}

  #exec { 'printonscreen':
  #path      => '/bin',
  #command   => 'echo SERVER UPDATE COMPLETED!',
  #logoutput => true,
  #}
   

  package { 'puppet-lint':
    ensure   => latest,
    provider => gem,
  }
  
  file { 'puppet.conf':
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    source  => 'puppet:///modules/puppet/puppet.conf',
    require => Package[ 'puppetserver' ],
    notify  => Service[ 'puppetserver' ],
  }
#
  file { 'site.pp':
    path    => '/etc/puppetlabs/code/manifests/site.pp',
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    source  => 'puppet:///modules/puppet/site.pp',
    require => Package[ 'puppetserver' ],
  }
#
  file { 'autosign.conf':
    path    => '/etc/puppetlabs/puppet/autosign.conf',
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    #source => 'puppet:///modules/puppet/autosign.conf',
    content => '*',
    require => Package[ 'puppetserver' ],
  }
#
  file { '/etc/puppetlabs/code/nodes.pp':
    ensure  => link,
    target  => '/vagrant/nodes.pp',
    require => Package[ 'puppetserver' ],
  }
#
  # initialize a template file then ignore
  file { '/vagrant/nodes.pp':
    ensure  => present,
    replace => false,
    source  => 'puppet:///modules/puppet/nodes.pp',
  }
  service { 'puppetserver':
    name => $servicename,
    enable => true,
    ensure => running,
  }

}
