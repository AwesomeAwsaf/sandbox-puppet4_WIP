# == Class: repos::apt
#
# This class installs the Puppet Labs APT repository.
#
# === Parameters
#
# === Actions
#
# - Install puppetlabs repository
# - Perform initial sync to update package database
#
# === Requires
#
# === Sample Usage
#
#   class { 'repos::apt': }
#
class repos::apt {

  $puppetlabs_key = '4BD6EC30'

  exec { 'apt_key_puppetlabs':
    path    => '/bin:/usr/bin',
    #unless  => "/usr/bin/apt-key list | /bin/grep -q '${puppetlabs_key}'",
    command => "apt-key adv --keyserver 'keyserver.ubuntu.com' --recv-keys '${puppetlabs_key}'",
    logoutput => true,
    before  => File[ 'puppetlabs.list' ],
  }

  file { 'puppetlabs.list':
    ensure  => present,
    path    => '/etc/apt/sources.list.d/puppetlabs.list',
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('repos/puppetlabs.list.erb'),
  }

  exec { 'apt_update':
    command     => '/usr/bin/apt-get update',
    subscribe   => File[ 'puppetlabs.list' ],
    refreshonly => true,
    logoutput => true,
    timeout     => 0,
  }

  exec { 'serverupdate':
    path    => '/bin:/usr/bin',
    command => '/usr/bin/wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb && /usr/bin/sudo dpkg -i puppetlabs-release-pc1-trusty.deb && /usr/bin/sudo /usr/bin/apt-get update', 
    logoutput => true,
    before  => Exec[ 'apt_key_puppetlabs' ],
  }

}
