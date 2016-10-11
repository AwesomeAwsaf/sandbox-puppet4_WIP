# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = 'awezone.com'

	# Require YAML module
		require 'yaml'
	# Read YAML file with box details
		node_config = YAML.load_file('nodes.yaml')

		Vagrant.configure(2) do |config|

		   node_config.each do |node_values|
		    config.vm.define node_values["name"] do |nodeconfig|
		      
		     nodeconfig.vm.box = node_values['box'] ### read box name from nodes.json
		     nodeconfig.vm.hostname = node_values['hostname'] #+ '.' + domain ### read hostname from nodes.json
			 nodeconfig.vm.network :private_network, ip: node_values['ip']#, auto_config: false # adapter:2,  ### read IP from nodes.json
			 #nodeconfig.vm.network :private_network, type: "dhcp"
			 #nodeconfig.ssh.insert_key=false

			 if node_values['fwdhost1'] ### check if nodes.json has 1st fwd'ing port info
        		nodeconfig.vm.network :forwarded_port, guest: node_values['fwdguest1'], host: node_values['fwdhost1'],
        		 id: node_values['portid1'], auto_correct: true
      		 end

      		 if node_values['fwdhost2'] ### check if nodes.json has 2nd fwd'ing port info
        		nodeconfig.vm.network :forwarded_port, guest: node_values['fwdguest2'], host: node_values['fwdhost2'],
        		 id: node_values['portid2'], auto_correct: true
      		 end

      		 if node_values['fwdhost3'] ### check if nodes.json has 3rd fwd'ing port info
        		nodeconfig.vm.network :forwarded_port, guest: node_values['fwdguest3'], host: node_values['fwdhost3'],
        		 id: node_values['portid3'], auto_correct: true
      		 end

			 nodeconfig.vm.post_up_message = node_values['msg'] ### message to displayed, read from nodes.json 
			 nodeconfig.vm.synced_folder "testdata", "/test_data", create: true  ### sync folder info not for all VMs
			 ### Further options for synced folders ###
			 #nodeconfig.vm.synced_folder "./", "/vagrant", disabled: true
			 #nodeconfig.vm.synced_folder "../data", "/vagrant_data", create: true
			 #nodeconfig.vm.synced_folder "./", "/vagrant", type: "rsync", rsync__exclude: ".git/",
			 		#rsync__args: ["--verbose", "--rsync-path='sudo rsync'", "--archive", "--delete", "-z"]
			 ### Need to run ###vagrant rsync### on host to trigger rsync OR 
			 ### Need to run ###"vagrant rsync-auto &"### command on the host to start the rsync on host and watch the sync from HOST-> GUEST in live
			 			 
			  	### All below steps only for Windows Guests###
				if  node_values['guestos'] ### To check if this is a Windows VM
			 		nodeconfig.vm.guest = node_values['guestos'] ### to specify guest tools to be installed for Virtualbox
			 		nodeconfig.vm.communicator = "winrm"
    		 		nodeconfig.winrm.username = "vagrant"
			 		nodeconfig.winrm.password = "vagrant"
			 		nodeconfig.windows.halt_timeout = 15
				    nodeconfig.vm.provision :shell, :path => "scripts/InstallNet4.ps1"
					nodeconfig.vm.provision :shell, :path => "scripts/SmokeCommands.ps1"
					nodeconfig.vm.provision :shell, :path => "scripts/InstallChocolatey.ps1"
					nodeconfig.vm.provision :shell, :path => "scripts/provision.ps1"
					nodeconfig.vm.provision :reload
					nodeconfig.vm.provision :shell, :path => "scripts/InstallPuppetFromMSI.ps1"
					nodeconfig.vm.provision :reload
	      	  		nodeconfig.vm.provision "shell", inline: "puppet agent --test --verbose > nul 2>&1"
	      	  		nodeconfig.vm.provision "shell", inline: "echo 'Windows-related-scripts-done'"
				end

			 ### All Virtualbox VM specific config
			 nodeconfig.vm.provider :virtualbox do |vb, override|
				vb.customize ["modifyvm", :id, "--memory", node_values['ram']]  ### setting RAM
				vb.customize ["modifyvm", :id, "--name", node_values['name']] ### Setting VM name in Virtualbox
				vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ] #### Windows 
				vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"] ### Clipboard sharing
				if  node_values['gui']
					vb.gui = node_values['gui'] ### get gui=true from nodes.json
				end
				vb.cpus = node_values['cpu'] ### set no. of cpus
			 end

	      	    if node_values['guestos'] != 'windows' ### Run the following for Linux Servers
	      	     nodeconfig.vm.provision :puppet do |puppet|
	              puppet.manifests_path = 'provision/manifests'
	              puppet.module_path = 'provision/modules'
	              puppet.options = "--verbose"
	    	     end
	    	    end
	      	  nodeconfig.vm.provision :shell, :path => node_values['bootstrap'] ### Run for all VMs
	    end
	end
end	