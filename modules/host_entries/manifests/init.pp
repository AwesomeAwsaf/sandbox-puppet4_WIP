## Updates the hosts file 
class host_entries {

  host { 'puppet.awezone.com':
    ip           => '10.10.10.10',
    host_aliases => ['puppet','puppet-master']
  }

  host { 'node1-ubuntu.awezone.com':
    ip           => '10.10.10.11',
    host_aliases => ['node1-ubuntu','node1'],
  }

  host { 'node2-centos':
    ip           => '10.10.10.12',
    host_aliases => ['node2-centos.awezone.com','node2'],
  }

  host { 'node3-windows':
    ip           => '10.10.10.15',
    host_aliases => ['node3-windows.awezone.com','node3'],
  }
}