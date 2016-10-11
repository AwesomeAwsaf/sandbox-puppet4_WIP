# == Class: helloworld
#
# This class is a bare bones example to ensure puppet master/clients are
# talking to each other.
#
# === Parameters
#
# === Actions
#
# === Requires
#
# === Sample Usage
#
# class { 'helloworld': }
#
class helloworld (
    $path = $helloworld::params::filepath,
    )inherits helloworld::params {

  file { $path:
    #owner   => 'root',
    #group   => 'root',
    #mode    => '0666',
    #content => "its my new world\n",
    content => template('helloworld/msg.erb'),
  }
}
