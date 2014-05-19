# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "lucid32"
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
  config.ssh.forward_agent = true

  # This will give the machine a static IP uncomment to enable
  config.vm.network :private_network, ip: "192.168.56.101"

  # Forward guest port 80 to host port 8888 and name mapping
  #config.vm.network :forwarded_port, guest: 80, host: 8888
  config.vm.network :forwarded_port, guest: 3306, host: 8890, auto_correct: true
  config.vm.network :forwarded_port, guest: 5432, host: 5434, auto_correct: true
  # livereload port
  config.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true
  config.vm.hostname = "adbox.nanigans.com"
  config.vm.synced_folder "../../src/nanigans", "/var/www", :owner => "www-data"

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", "512"]
  end

  # Enable the Puppet provisioner, with will look in manifests
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = "modules"
    #puppet.options = "--verbose --debug"
  end

end

