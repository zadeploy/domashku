#!/bin/bash

killall -r infinite-loop
update-rc.d -f infinite-loop remove 
rm -f /etc/init.d/infinite-loop 

sudo service apache2 start
openssl  req -x509 -sha256 -nodes -newkey rsa:2048 -keyout server.key -out server.pem \
    -subj "/C=BY/ST=Slonim/L=local/O=local/OU=local/CN=localhost/emailAddress=56_dimon@mail.ru" 
sudo cp server.pem /etc/ssl/certs/
sudo cp server.key /etc/ssl/private/
sudo chmod 0600 /etc/ssl/private/server.key
sudo a2enmod ssl
sudo a2ensite default-ssl
#fix server name
sudo sed -i '220a\ServerName localhost' /etc/apache2/apache2.conf
sudo service apache2 restart
sudo sed -i '25a\SSLProtocol all -SSLv2' /etc/apache2/sites-enabled/default-ssl.conf
sudo sed -i '33c\SSLCertificateFile    /etc/ssl/certs/server.pem' /etc/apache2/sites-enabled/default-ssl.conf
sudo sed -i '34c\SSLCertificateKeyFile /etc/ssl/private/server.key' /etc/apache2/sites-enabled/default-ssl.conf

sudo a2enmod alias

sudo sed -i '25a\Redirect permanent / https://localhost:8443/' /etc/apache2/sites-enabled/000-default.conf

sudo sed -i '132a\WSGIScriptAlias /app /var/www/app/app.wsgi' /etc/apache2/sites-enabled/default-ssl.conf

sudo service apache2 restart

sudo apt-get update
sudo apt install memcached -y

echo "* * * * * ./exercise-memcached.sh" | crontab - -u vagrant

sudo service cron restart

