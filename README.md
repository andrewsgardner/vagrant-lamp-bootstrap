# vagrantStack

A vagrant dev stack that provisions Apache, MySQL, PHP5, phpMyAdmin, NodeJS, and MongoDB.

<!-- ### Whaaaaat ? -->

## Modify Your Computer's Hosts File

Update your machine's hosts file to include ip and domian properties set in the [Vagrantfile](https://github.com/andrewsgardner/vagrantStack/blob/master/Vagrantfile). This should exist in C:\Windows\System32\drivers\etc\hosts if you're using Windows 10.

`192.168.33.16 vagrantstack.vm`

## Features

An Ubuntu 12.04 LTS 64bit box will be provisioned with the following features:

* Set a custom name for your project directory at `/var/www/${PROJECT_DIR}`

* Set a custom name for the document root at `/var/www/${PROJECT_DIR}/${DOCUMENT_ROOT}`

* Configure Apache to use a custom port and hostname*.

* Automatically start your Node server on provision.

* Set a custom path to your Node server.

* Set a pre-chosen password for MySQL.

* Set a pre-chosen password for phpMyAdmin.

###### * Ensure that Apache and MongoDB/Node server aren't running on the same port. The default is 80.

## How To Use

Put the project files in this repository inside a folder and do a `vagrant up` on the command line.

## Vagrant Destroy Workaround

You may receive an error when doing a `vagrant destroy` like the following:


```
An action 'destroy' was attempted on the machine 'default',
but another process is already executing an action on the machine.
Vagrant locks each machine for access by only one process at a time.
Please wait until the other Vagrant process finishes modifying this
machine, then try again.
```
The VM can be destroyed by killing a process called vagrant.

1. SSH into the box: `vagrant ssh`
2. Locate the process number for vagrant: `ps aux | grep vagrant`
3. Kill the vagrant process: `sudo kill <PROCESS_NUMBER>`
4. Exit the vagrant box: `exit`
5. Destroy the VM: `vagrant destroy`
