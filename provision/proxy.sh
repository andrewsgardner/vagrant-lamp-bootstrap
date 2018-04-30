#!/usr/bin/env bash

echo "Setting NodeJS port as a proxy on Apache..."

APACHE_CONF=$(cat <<EOF
<VirtualHost *:${APACHE_PORT}>
    ServerAdmin webmaster@${PROJECT_DIR}
    DocumentRoot /var/www/${PROJECT_DIR}/${DOCUMENT_ROOT}
    ProxyRequests Off
    ProxyPreserveHost On
    ProxyVia Full

    <Proxy *>
        Require all granted
    </Proxy>

    <Location />
      ProxyPass http://${PROJECT_DIR}:3000
      ProxyPassReverse http://${PROJECT_DIR}:3000
    </Location>

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
    ProxyRequests Off
    ProxyPreserveHost On
    ProxyVia Full

    <Proxy *>
        Require all granted
    </Proxy>

    <Location />
      ProxyPass http://${PROJECT_DIR}:3000
      ProxyPassReverse http://${PROJECT_DIR}:3000
    </Location>

    <Directory "/var/www/${PROJECT_DIR}/${DOCUMENT_ROOT}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)

sudo chmod 755 /var/www/${PROJECT_DIR}
sudo apt-get update
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo service apache2 restart
echo "${APACHE_CONF}" > /etc/apache2/sites-available/default
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf
sudo service apache2 restart
sudo node /var/www/${PROJECT_DIR}/server/server.js
