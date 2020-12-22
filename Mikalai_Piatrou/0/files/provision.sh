#!/bin/bash

sudo killall -r S20infinite-loop

sudo apt update

#conf
cp /tmp/site.conf /etc/apache2/sites-available/site.conf
a2ensite site.conf

#ssl enabling
sudo a2enmod ssl rewrite
sudo mkdir /etc/apache2/ssl

# Cert
sudo openssl genrsa -out /etc/apache2/ssl/test.key 2048
sudo openssl req -new -x509 -key /etc/apache2/ssl/test.key -out /etc/apache2/ssl/test.pem -days 365 -subj /CN=localhost

#cronjob
sudo apt-get install memcached

{ crontab -l -u vagrant; echo '1 * * * * sudo -u vagrant /home/vagrant/exercise-memcached.sh'; } | crontab -u vagrant -
sudo service cron restart

sudo service apache2 restartle of how to do basic provisioning with shell scripts."
service apache2 stop  1>&2 > /dev/null  # I lied