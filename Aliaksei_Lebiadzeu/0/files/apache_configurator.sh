#!/bin/bash

echo "Creating SSL certificate and key"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/devops-test.key -out /etc/ssl/certs/devops-test.crt -batch 2>/dev/null

echo "Updating Apache configs"
cp /tmp/site.conf /etc/apache2/sites-available/000-default.conf
cp /tmp/ssl-params.conf /etc/apache2/conf-available/ssl-params.conf

echo "Enabling ssl"
a2enmod ssl > /dev/null 2>&1
a2enmod headers > /dev/null 2>&1
a2enconf ssl-params > /dev/null 2>&1

echo "Restarting Apache"
service apache2 restart > /dev/null 2>&1
