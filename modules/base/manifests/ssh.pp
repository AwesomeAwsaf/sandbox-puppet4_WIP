class base::ssh {
	package {'openssh-package':
		name => 'openssh-server',
		ensure => present,
	}

	file {'/etc/ssh/ssh_config':
		ensure => file,
		owner => root,
		require => Package['openssh-package'],
	}

	service { 'sshd':
		enable      => true,
		ensure      => running,
		subscribe => File['/etc/ssh/ssh_config']
	}
}