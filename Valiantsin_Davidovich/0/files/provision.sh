#!/bin/bash
echo "[Fix health of the system]"

echo "Kill S20infinite-loop"
killall S20infinite-loop
echo "Remove S20infinite-loop"
update-rc.d -f S20infinite-loop remove
rm -f /etc/rc2.d/S20infinite-loop

echo "[Copy site.conf]"

cp /tmp/site.conf /etc/apache2/sites-available/site.conf
a2ensite site.conf

echo "Add rewrite"
a2enmod rewrite

echo "[Create SSL certificate and key]"
mkdir -p /etc/apache2/ssl

openssl genrsa -out /etc/apache2/ssl/devops-test.key 2048
openssl req -new -x509 -key /etc/apache2/ssl/devops-test.key -out /etc/apache2/ssl/devops-test.cert -days 3650 -subj /CN=localhost
a2enmod ssl


echo "[Install memcached]"
apt-get update
apt-get install memcached
service memcached restart

echo "[Add cronjob that runs memcached]"
apt-get install cron -y
{ crontab -l -u vagrant; echo '* * * * * sudo -u vagrant /home/vagrant/exercise-memcached.sh'; } | crontab -u vagrant -
service cron restart

service apache2 start














