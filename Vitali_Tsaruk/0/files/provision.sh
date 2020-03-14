#!/bin/bash

killall -r infinite-loop 1>&2 > /dev/null
update-rc.d -f infinite-loop remove 1>&2 > /dev/null
rm -f /etc/init.d/infinite-loop 1>&2 > /dev/null

cp /tmp/app.py /var/www/app/app.py >/dev/null 2>/dev/null
cp /tmp/site.conf /etc/apache2/sites-available/000-default.conf > /dev/null
mkdir /etc/apache2/ssl > /dev/null
openssl req -new -x509 -days 1461 -nodes -out /etc/apache2/ssl/cert.pem -keyout /etc/apache2/ssl/cert.key -subj "/C=RU/ST=test/L=test/O=test/OU=test/CN=test/CN=test" 2>/dev/null
chmod 0600 /etc/apache2/ssl/cert.key > /dev/null
a2enmod ssl > /dev/null
a2enmod wsgi > /dev/null
a2enmod rewrite > /dev/null
service apache2 restart 1>&2 > /dev/null

apt-get update 1>&2 > /dev/null
apt-get install memcached -y 1>&2 > /dev/null
service memcached restart 1>&2 > /dev/null
echo "*/1 * * * * /home/vagrant/exercise-memcached.sh" | crontab - -u vagrant
crontab -l -u vagrant
service cron restart



#echo "Hi, I don't do anything right now. I'm just an example of how to do basic provisioning with shell scripts."
#service apache2 stop  1>&2 > /dev/null  # I lied