#!/usr/bin/env bash

VHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerName $HOSTNAME
    DocumentRoot "/var/www/${PROJECT_DIR}/${DOCUMENT_ROOT}"
    <Directory "/var/www/${PROJECT_DIR}/${DOCUMENT_ROOT}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)

echo "Installing Apache..."

sudo mkdir "/var/www/${PROJECT_DIR}/${DOCUMENT_ROOT}"
sudo apt-get update
sudo apt-get install -y apache2
sudo sed -i s,/var/www,/var/www/${PROJECT_DIR}/${DOCUMENT_ROOT},g /etc/apache2/sites-available/default
sudo rm /var/www/index.html
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite
sudo service apache2 restart
