#!/usr/bin/env bash

echo "Installing PHP..."

sudo apt-get update
sudo apt-get install -y php libapache2-mod-php php-mcrypt php-mysql
