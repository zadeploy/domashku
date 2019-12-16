#!/bin/bash


# SSL
 a2enmod ssl > /dev/null 2>&1
 echo "SSL enable"


# mod_rewrite
a2enmod rewrite > /dev/null 2>&1
 echo "mod_rewrite enable"


# Cert
mkdir /etc/apache2/ssl >/dev/null 2>&1
openssl req -new -x509 -days 365 -nodes -out /etc/apache2/ssl/cert.pem -keyout /etc/apache2/ssl/cert.key -subj "/C=BY/ST=test/L=test/O=test/OU=IT/CN=localhost/CN=test"  > /dev/null 2>&1
echo "cert ok"


# Website
cp /tmp/site.conf /etc/apache2/sites-available/site.conf > /dev/null 2>&1
a2ensite site.conf > /dev/null 2>&1
a2dissite 000-default.conf > /dev/null 2>&1
echo "website ok"


# Restart apache
service apache2 restart >/dev/null 2>&1
echo "restart apache"


# Memcached
apt-get update >/dev/null 2>&1
apt-get install memcached -y >/dev/null 2>&1
apt-get install libmemcached-tools -y >/dev/null 2>&1
service memcached restart >/dev/null 2>&1
echo "Memcached install"
