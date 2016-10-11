# == Class: puppet
#
# This class installs and manages the Puppet client daemon.
#
# === Parameters
#
# [*ensure*]
#   What state the package should be in. Defaults to +latest+. Valid values are
#   +present+ (also called +installed+), +absent+, +purged+, +held+, +latest+,
#   or a specific version number.
#
# === Actions
#
# - Install Puppet client package
# - Ensure puppet-agent daemon is running
#
# === Requires
#
# === Sample Usage
#
#   class { 'puppet': }
#
#   class { 'puppet':
#     ensure => '2.6.8-0.5.el5',
#   }
#
class puppet(
  $ensure = $puppet::params::client_ensure,
  $package_name = $puppet::params::client_package_name,
  $servicename  = $puppet::params::client_service_name,
) inherits puppet::params {

  #if $osfamily == 'debian' and $ensure != 'latest' {
  #  class { 'puppet::apt_pin':
  #    version => $ensure
  #  }
  #}

  package { 'puppet-agent':
    ensure  => $ensure,
    #name    => $package_name,
  }
  package { 'puppet':
    ensure  => absent,
  }
  # required to start client agent on ubuntu
  #exec { 'start_puppet':
  #  #command => '/bin/sed -i /etc/default/puppet -e "s/START=no/START=yes/"',
  #  command => '/usr/bin/sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true',
  #  onlyif  => '/usr/bin/test -f /etc/default/puppet',
  #  require => Package[ 'puppet-agent' ],
  #  before  => Service[ 'puppet' ],
  #}

  service { 'puppet':
    enable  => true,
    ensure  => running,
    require => Package[ 'puppet-agent' ],
  }

}
