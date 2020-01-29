#!/bin/bash

echo "Fix health"
killall -r infinite-loop >/dev/null 2>/dev/null
update-rc.d -f infinite-loop remove >/dev/null 2>/dev/null
rm -f /etc/init.d/infinite-loop >/dev/null 2>/dev/null

echo "Add SSL support"
a2enmod ssl >/dev/null 2>/dev/null

echo "Add mod_rewrite support"
a2enmod rewrite >/dev/null 2>/dev/null

echo "Add cert"
country=BY
state=localhost
locality=localhost
organization=localhost
organizationalunit=IT
commonname=localhost
email=localhost@localhost

mkdir /etc/apache2/ssl >/dev/null 2>/dev/null
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/localhost.key -out /etc/apache2/ssl/localhost.crt \
    -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email" >/dev/null 2>/dev/null

echo "Add site.conf"
cp /tmp/site.conf /etc/apache2/sites-available/site.conf >/dev/null 2>/dev/null
a2ensite site.conf >/dev/null 2>/dev/null

echo "Install memcached"
apt-get update >/dev/null 2>/dev/null
apt-get install memcached -y >/dev/null 2>/dev/null
service memcached restart >/dev/null 2>/dev/null

echo "Setup cron"
apt-get install cron -y >/dev/null 2>/dev/null
crontab -l -u vagrant | { cat; echo "*/1 * * * * /home/vagrant/exercise-memcached.sh"; } | crontab -u vagrant - >/dev/null 2>/dev/null
service cron restart

echo "Edit app"
cp /tmp/app.py /var/www/app/app.py >/dev/null 2>/dev/null

echo "Restart Apache2"
service apache2 restart >/dev/null 2>/dev/null