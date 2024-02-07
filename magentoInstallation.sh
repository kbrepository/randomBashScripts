#!/bin/bash
sudo apt update
### install apache
sudo apt install apache2
sudo systemctl enable apache2.service

### Configure Apache2 Virtual Host
cat << 'EOF' >> /etc/apache2/sites-available/magento2.conf
<VirtualHost *:80>
     ServerAdmin admin@domain.com
     DocumentRoot /var/www/html/magento2/
     ServerName domain.com
     ServerAlias www.domain.com

     <Directory /var/www/html/magento2/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
     </Directory>

     ErrorLog ${APACHE_LOG_DIR}/error.log
     CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF


### Enable rewrite mod

sudo a2ensite magento2.conf
sudo a2enmod rewrite

## Install PHP and extensions

sudo apt install php7.2 libapache2-mod-php7.2 php7.2-common php7.2-gmp php7.2-curl php7.2-soap php7.2-bcmath php7.2-intl php7.2-mbstring php7.2-xmlrpc php7.2-mcrypt php7.2-mysql php7.2-gd php7.2-xml php7.2-cli php7.2-zip
