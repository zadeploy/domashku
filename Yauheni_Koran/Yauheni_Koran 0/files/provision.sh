#!/bin/bash

#fix processor load
killall -r infinite-loop
update-rc.d -f infinite-loop remove 
rm -f /etc/init.d/infinite-loop 

#components update
sudo apt update

# create SSL certificate
openssl  req -x509 -sha256 -nodes -newkey rsa:2048 -keyout server.key -out server.pem \
    -subj "/C=BY/ST=Minsk/L=lh/O=lh/OU=lh/CN=localhost/emailAddress=test@local.host" 
sudo cp server.pem /etc/ssl/certs/
sudo cp server.key /etc/ssl/private/
sudo chmod 0600 /etc/ssl/private/server.key
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo sed -i '25a\SSLProtocol all -SSLv2' /etc/apache2/sites-enabled/default-ssl.conf
sudo sed -i '33c\SSLCertificateFile    /etc/ssl/certs/server.pem' /etc/apache2/sites-enabled/default-ssl.conf
sudo sed -i '34c\SSLCertificateKeyFile /etc/ssl/private/server.key' /etc/apache2/sites-enabled/default-ssl.conf

sudo sed -i '56s!#!ServerName localhost!' /etc/apache2/apache2.conf

cp /tmp/site.conf /etc/apache2/sites-available/site.conf
a2ensite site.conf

sudo a2enmod alias

# redirect to https
sudo sed -i '9a\Redirect / https://localhost:8443/' /etc/apache2/sites-available/000-default.conf
sudo sed -i '41a\<VirtualHost *:443>\
 SSLEngine On\
SSLCertificateFile   /etc/ssl/certs/server.pem\
SSLCertificateKeyFile /etc/ssl/private/server.key\
WSGIDaemonProcess python_https processes=3 threads=15 display-name=%{GROUP}\
        WSGIProcessGroup python_https\
        WSGIScriptAlias /app /var/www/app/app.wsgi\
        WSGIScriptReloading On\
        <Directory /var/www/app>\
                Order allow,deny\
                Allow from all\
       </Directory>\
</VirtualHost>\
' /etc/apache2/sites-available/000-default.conf
sudo service apache2 restart

# install memcached
sudo apt install memcached -y
sudo service memcached restart

#create cronjob
crontab -l > mycron
echo "* * * * * /home/vagrant/exercise-memcached.sh" >> mycron
sudo crontab -u vagrant mycron
rm mycron
sudo service cron restart
