## install Git
class putty {
#include chocolatey

    package { 'putty':
      ensure   => 'latest',
      provider => 'chocolatey',
  }
}
