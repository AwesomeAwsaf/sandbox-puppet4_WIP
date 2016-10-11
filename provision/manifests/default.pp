#
# site.pp - defines defaults for vagrant provisioning
#

# use run stages for minor vagrant environment fixes
#stage { 'pre': before => Stage['main'], }
#stage { 'final': require => Stage['main'],}

#class { 'repos': stage => pre }
#class { 'vagrant': stage => 'pre' }

stage { 'first':  before => Stage['main'], }
stage { 'last': }
Stage['main'] -> Stage['last']


class { 'repos': stage => first }
class { 'puppet': }
#class { 'networking': }

if $hostname == 'puppet' {
  class { 'puppet::server': stage => last}
}