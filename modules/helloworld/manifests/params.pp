#Parameters for Hello world class

class helloworld::params {

  case $::osfamily {
    'redhat': {
      $filepath = '/tmp/hello.txt'
    }
    'debian': {
      $filepath = '/tmp/hello.txt'
    }
    'windows': {
      $filepath = 'c:/tmp/hello.txt'
    }

    default: {
      fail("Module 'helloworld' is not currently supported on ${::operatingsystem}")
    }
  }

}