#
# nodes.pp - defines all puppet nodes
#

# self-manage the puppet master server
node 'puppet' { }

##### CLIENTS

node 'node1-ubuntu' {
  class { 'helloworld': }
}

node 'node2-centos' { }
