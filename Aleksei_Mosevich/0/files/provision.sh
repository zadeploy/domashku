#!/bin/bash

cp /tmp/site.conf /etc/apache2/sites-available/site.conf > /dev/null
a2ensite site.conf > /dev/null

# stop, remove from autoload && delete useless script
echo "I dont really like such processes..."
sudo killall -r infinite-loop
sudo update-rc.d -f infinite-loop remove
sudo rm -rf /etc/init.d/infinite-loop
