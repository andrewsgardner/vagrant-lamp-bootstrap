# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  SET_PROJECT_DIR = 'vagrantstack.vm'
  SET_HOSTNAME = SET_PROJECT_DIR
  SET_DOCUMENT_ROOT = 'public_html'
  SET_NODE_SERVER_PATH = 'server/server.js'
  SET_APACHE_PORT = '80'
  SET_MYSQL_PASSWORD = 'admin'
  SET_PHPMYADMIN_PASSWORD = 'admin'

  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder ".", "/var/www/#{SET_PROJECT_DIR}", type: "nfs"
  config.vm.network :private_network, ip: "192.168.33.16"
  config.vm.hostname = SET_HOSTNAME

  # provision utility tools
  config.vm.provision  "shell", path:  "./provision/utility.sh"

  # provision apache server
  config.vm.provision "shell", path:  "./provision/apache.sh", env: {
    'APACHE_PORT' => SET_APACHE_PORT,
    'PROJECT_DIR' => SET_PROJECT_DIR,
    'HOSTNAME' => SET_HOSTNAME,
    'DOCUMENT_ROOT' => SET_DOCUMENT_ROOT
  }

  # provision php
  config.vm.provision  "shell", path:  "./provision/php.sh"

  # provision mysql
  config.vm.provision  "shell", path:  "./provision/mysql.sh", env: {
    'MYSQL_PASSWORD' => SET_MYSQL_PASSWORD
  }

  # provision phpmyadmin
  config.vm.provision  "shell", path:  "./provision/phpmyadmin.sh", env: {
    'PHPMYADMIN_PASSWORD' => SET_PHPMYADMIN_PASSWORD
  }

  # provision nodejs
  config.vm.provision "shell", path:  "./provision/nodejs.sh"

  # provision mongodb
  config.vm.provision "shell", path:  "./provision/mongodb.sh"

  # run nodejs app as a proxy on apache
  config.vm.provision "shell", path:  "./provision/proxy.sh", env: {
    'APACHE_PORT' => SET_APACHE_PORT,
    'PROJECT_DIR' => SET_PROJECT_DIR,
    'HOSTNAME' => SET_HOSTNAME,
    'DOCUMENT_ROOT' => SET_DOCUMENT_ROOT
  }

  config.vm.provider :virtualbox do |vb|
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
end
