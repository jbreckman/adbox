Vagrant.configure("2") do |config|

  # Enable the Puppet provisioner, with will look in manifests
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = "modules"
  end

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "lucid32"

  config.vm.network :private_network, ip: "192.168.56.101"

  # Forward guest port 80 to host port 8888 and name mapping
  #config.vm.network :forwarded_port, guest: 80, host: 8888
  config.vm.network :forwarded_port, guest: 3306, host: 8890, auto_correct: true
  config.vm.network :forwarded_port, guest: 5432, host: 5434, auto_correct: true
  config.vm.hostname = "local.nanigans.com"

  config.vm.synced_folder "../nanigans", "/home/vagrant/nanigans", :owner => "www-data"
end
