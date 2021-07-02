#!/bin/bash
echo "kill infinite loop"
pkill -f "S20infinite-loop" > /dev/null
rm -f /etc/rc2.d/S20infinite-loop

echo "generate cert"
cp -f /tmp/openssl.cnf /etc/ssl/openssl.cnf
openssl req -nodes -x509 -newkey rsa:4096 -in /etc/ssl/server.csr -keyout /etc/ssl/private/key.key -out /etc/ssl/certs/cert.cert -days 365 \
-subj "/C=BY/ST=Belarus/L=Minsk/O=devops/OU=zadeploy/CN=localhost/emailAddress=vlad.bykouski@gmail.com" >/dev/null 2>/dev/null

echo "configure apache"
echo "ServerName localhost" >> /etc/apache2/apache2.conf
a2enmod ssl >/dev/null
a2enmod rewrite >/dev/null

echo "copy config files"
cp /tmp/index.html /var/www/
cp /tmp/site.conf /etc/apache2/sites-available/site.conf > /dev/null

echo "enable apache"
a2dissite 000-default.conf >/dev/null
a2ensite site.conf > /dev/null
service apache2 reload >/dev/null

echo "install memcached"
apt-get update >/dev/null 2>/dev/null
apt-get install memcached>/dev/null 2>/dev/null
echo "* * * * * /home/vagrant/exercise-memcached.sh;" > temp
crontab -u vagrant temp>/dev/null 2>/dev/null
rm -f temp

