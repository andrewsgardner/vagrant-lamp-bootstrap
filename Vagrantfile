Vagrant.configure("2") do |config|

  SET_PROJECT_DIR = 'vagrantstack.dev'
  SET_HOSTNAME = SET_PROJECT_DIR

  config.vm.box = "precise64"
  config.vm.box_url = "https://files.vagrantup.com/precise64.box"
  config.vm.synced_folder ".", "/var/www/#{SET_PROJECT_DIR}", type: "nfs"
  config.vm.network :private_network, ip: "10.0.33.34"
  config.vm.hostname = SET_HOSTNAME

  # provision utility tools
  config.vm.provision  "shell", path:  "./provision-utility.sh"

  # provision apache server
  config.vm.provision "shell", path:  "./provision-apache.sh", env: {'PROJECT_DIR' => SET_PROJECT_DIR, 'HOSTNAME' => SET_HOSTNAME}

  # provision nodejs
  #config.vm.provision "shell", path:  "./provision-nodejs.sh"

  # provision mongodb
  #config.vm.provision "shell", path:  "./provision-mongodb.sh"

  # start services
  #config.vm.provision "shell", path:  "./setup.sh", run: "always"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end
end
