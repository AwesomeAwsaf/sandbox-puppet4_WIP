## install DNS BIND utils

class binddns {

  $updatecommand = $osfamily ? {
  'Redhat'  => '/usr/bin/yum makecache',
  'Debian'  => '/usr/bin/apt-get update',
  'Windows' => 'choco list -la',
  }

  $dnsutil = $osfamily ? {
    'Redhat'  => 'bind-utils.x86_64',
    'Debian'  => 'bind9utils',
    'Windows' => 'bind-toolsonly',
  }

    package { $dnsutil:
      ensure  => latest,
      require => Exec[ 'update' ]
  }

    exec { update:
    command => $updatecommand,
   }
}
