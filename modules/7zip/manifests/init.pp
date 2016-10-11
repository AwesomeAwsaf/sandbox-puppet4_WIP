## install Git
class 7zip {
#include chocolatey

    package { '7zip.install':
      ensure   => 'latest',
      provider => 'chocolatey',
  }
}
