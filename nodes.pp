#
# nodes.pp - defines all puppet nodes
#

if $::kernel == 'windows' {
  Package { provider => chocolatey, }
}

# self-manage the puppet master server
node 'puppet' { 
  #class { 'puppet_lint': }
  class { 'helloworld': }
  class { 'host_entries': }
}

##### CLIENTS

node 'node1-ubuntu' {
  #include helloworld
  include host_entries
  #include puppetconfigfile
  #include binddns
  include base
  include base::if
  #class { 'puppetexec':}
}

node 'node2-centos' { 
  include helloworld
  include host_entries
  include binddns
  class { 'puppetconfigfile': }
}

node 'node3-windows' {
  class { 'host_entries': }
  class { 'git': }
  class { 'helloworld': }
  class { 'flush_dns': }
  #class { '7zip': }
  #class { 'basetools': }
}
