#!/usr/bin/env bash

APACHE_PORTS=$(cat <<EOF
NameVirtualHost *:${APACHE_PORT}
Listen ${APACHE_PORT}

<IfModule mod_ssl.c>
    Listen 443
</IfModule>

<IfModule mod_gnutls.c>
    Listen 443
</IfModule>
EOF
)

APACHE_CONF=$(cat <<EOF
<VirtualHost *:${APACHE_PORT}>
    ServerAdmin webmaster@${PROJECT_DIR}
    DocumentRoot /var/www/${PROJECT_DIR}/${DOCUMENT_ROOT}

    <Directory />
        Options FollowSymLinks
        AllowOverride None
    </Directory>

    <Directory /var/www/${PROJECT_DIR}/${DOCUMENT_ROOT}/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride None
        Order allow,deny
        allow from all
    </Directory>

    ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
    <Directory "/usr/lib/cgi-bin">
        AllowOverride None
        Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
        Order allow,deny
        Allow from all
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log

    # Possible values include: debug, info, notice, warn, error, cri$
    # alert, emerg.
    LogLevel warn

    CustomLog \${APACHE_LOG_DIR}/access.log combined

    Alias /doc/ "/usr/share/doc/"
    <Directory "/usr/share/doc/">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride None
        Order deny,allow
        Deny from all
        Allow from 127.0.0.0/255.0.0.0 ::1/128
    </Directory>

</VirtualHost>
EOF
)

VHOST=$(cat <<EOF
<VirtualHost *:${APACHE_PORT}>
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
sudo rm /var/www/index.html
echo "${APACHE_PORTS}" > /etc/apache2/ports.conf
echo "${APACHE_CONF}" > /etc/apache2/sites-available/default
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite
sudo service apache2 restart
