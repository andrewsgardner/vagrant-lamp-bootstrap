#!/usr/bin/env bash

echo "Installing MySQL..."

sudo apt-get update
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD"
sudo apt-get -y install mysql-server
