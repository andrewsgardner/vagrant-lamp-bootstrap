#!/usr/bin/env bash

echo "Installing Apache..."

#sudo apt-get update
#sudo apt-get -y install apache2
#sudo rm -Rf /var/www/html

#PROJECTDIR='andrewsgardner.dev'

sudo mkdir "/var/www/${PROJECT_DIR}"

sudo apt-get update
#sudo apt-get -y upgrade

sudo apt-get install -y apache2

VHOST=$(cat <<EOF
<VirtualHost *:80>
    # test
    ServerName $HOSTNAME
    DocumentRoot "/var/www/${PROJECT_DIR}"
    <Directory "/var/www/${PROJECT_DIR}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

sudo a2enmod rewrite
service apache2 restart

echo "The dir is $PROJECT_DIR and $HOSTNAME"
