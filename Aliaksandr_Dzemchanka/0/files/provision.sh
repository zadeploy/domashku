#!/bin/bash
sudo killall -r infinite-loop
sudo update-rc.d -f infinite-loop remove &2>/dev/null
sudo rm /etc/init.d/infinite-loop

cp /tmp/site.conf /etc/apache2/sites-available/site.conf > /dev/null
sudo a2enmod ssl
a2dissite 000-default.conf
a2ensite default-ssl
a2ensite site.conf > /dev/null

echo "generate ssl"
openssl genrsa -out /etc/apache2/server.key 2048
openssl req -new -x509 -key /etc/apache2/server.key -out /etc/apache2/server.cert -days 3650 -subj /CN=example.com

echo "Hi, I don't do anything right now. I'm just an example of how to do basic provisioning with shell scripts."
service apache2 restart  1>&2 > /dev/null  # I lied

echo "install memcashed"
sudo apt-get update
sudo apt install memcached

echo "install cron"
echo "* * * * * ./exercise-memcached.sh" | crontab - -u vagrant
service cron restart

