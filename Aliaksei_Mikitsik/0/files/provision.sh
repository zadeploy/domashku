#!/bin/bash

killall -r infinite-loop &>/dev/null
update-rc.d -f infinite-loop remove &>/dev/null
rm -rf /etc/init.d/infinite-loop &>/dev/null

sudo apt update

# a2enmod ssl &>/dev/null

# cp /tmp/site.conf /etc/apache2/sites-available/site.conf > /dev/null
# a2ensite site.conf > /dev/null

