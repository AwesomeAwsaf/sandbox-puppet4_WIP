## install basic tools
class basetools {

    package { ['boxstarter', 'putty', 'sysinternals', 'winscp', 'winrar', 'ruby1.9']:
      ensure   => 'installed',
      provider => 'chocolatey',
  }
}
