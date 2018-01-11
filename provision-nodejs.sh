#!/usr/bin/env bash

echo "Installing NodeJS..."

sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get -y update
sudo apt-get install -y nodejs
