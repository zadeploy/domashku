#!/bin/bash

#Kill all processes
sudo killall -r S20 infinite-loop

#Chech for updates
sudo apt-get update
echo "All dependencies are up-to-date"
sudo apt-get install memcached
echo "++ Memcached"

#Conf
cp /tmp/site.conf /etc/apache2/sites-available/site.conf
a2ensite site.conf

#SSL
sudo a2enmod ssl rewrite
sudo mkdir /etc/apache2/ssl

#Cert
sudo openssl genrsa -out /etc/apache2/ssl/test.key 2048
sudo openssl req -new -x509 -key /etc/apache2/ssl/test.key -out /etc/apache2/ssl/test.pem -days 365 -subj /CN=localhost

{ crontab -l -u vagrant; echo '1 * * * * sudo -u vagrant /home/vagrant/exercise-memcached.sh'; } | crontab -u vagrant -
sudo service cron restart

sudo service apache2 restart