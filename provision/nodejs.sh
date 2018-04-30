#!/usr/bin/env bash

echo "Installing NodeJS..."

cd ~
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get -y install build-essential
sudo apt-get update
sudo apt-get -y install nodejs
