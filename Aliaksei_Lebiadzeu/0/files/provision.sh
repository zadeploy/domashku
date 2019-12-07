#!/bin/bash

ps aux | grep infinite-loop 
sudo killall -r infinite-loop # kill current infinite-loop processes
sudo update-rc.d -f infinite-loop remove &2>/dev/null # unregister infinite-loop from autostart
sudo rm /etc/init.d/infinite-loop # remove file with infinite-loop script

cp /tmp/site.conf /etc/apache2/sites-available/site.conf > /dev/null
a2ensite site.conf > /dev/null

echo "Hi, I don't do anything right now. I'm just an example of how to do basic provisioning with shell scripts."
sudo service apache2 reload  #1>&2 > /dev/null
