# == Class: puppet::params
#
# This class manages the Puppet parameters.
#
# === Parameters
#
# === Actions
#
# === Requires
#
# === Sample Usage
#
# This class file is not called directly.
#
class puppet::params {

  $client_ensure = 'installed'
  $server_ensure = 'installed'

  case $::osfamily {
    'redhat': {
      #$server_package_name = 'puppet-server'
      $server_package_name = 'puppetserver'
      $server_service_name = 'puppetserver'
      #$server_service_name = 'puppetmaster'
    }
    'debian': {
      #$server_package_name = 'puppetmaster-passenger'
      #$server_service_name = 'apache2'
      #$server_service_name = 'puppetmaster'
      #$server_package_name = 'puppetmaster'
      $server_service_name = '/opt/puppetlabs/bin/puppetserver'
      $server_package_name = 'puppetserver'
      $client_package_name = 'puppet-agent'
    }
    default: {
      fail("Module 'puppet' is not currently supported by Puppet Sandbox on ${::operatingsystem}")
    }
  }

}
