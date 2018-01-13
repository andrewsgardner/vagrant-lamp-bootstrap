#!/usr/bin/env bash

VHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerName $HOSTNAME
    DocumentRoot "/var/www/${PROJECT_DIR}"
    <Directory "/var/www/${PROJECT_DIR}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)

echo "Installing Apache..."

sudo mkdir "/var/www/${PROJECT_DIR}"
sudo apt-get update
sudo apt-get install -y apache2
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite
service apache2 restart
