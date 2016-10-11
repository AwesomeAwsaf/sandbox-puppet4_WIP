## install Git
class git {
#include chocolatey
if $::kernel == 'windows' {
  Package { provider => chocolatey, }
}

  package { 'git':
    ensure   => 'latest',
    #provider => 'chocolatey',
  }
}
