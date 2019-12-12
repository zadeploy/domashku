#!/bin/bash

#Configurate flask app
cp -r /tmp/app /var/www
echo "Flask app configurated"
#Enable ssl
a2enmod ssl > /dev/null 2>&1
echo "SSL mode enabled"

#Install memcached
sudo apt-get update > /dev/null 2>&1
echo "Packages updated"
sudo apt-get install memcached > /dev/null 2>&1
echo "Memcached installed"

#Install and enable wsgi
apt-get install libapache2-mod-wsgi > /dev/null 2>&1
a2enmod wsgi > /dev/null 2>&1
echo "WSGI enabled"

#Configurate apache2
cp /tmp/site.conf /etc/apache2/sites-available/site.conf > /dev/null
a2ensite site.conf > /dev/null

#Restart apache2
sudo service apache2 restart > /dev/null 2>&1

echo "Apache successfully started!"
