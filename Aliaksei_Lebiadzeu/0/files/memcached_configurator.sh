#!/bin/bash

echo "Packages updating"
apt-get update > /dev/null 2>&1

echo "Memcached installing"
apt-get install memcached > /dev/null 2>&1

netstat -plunt | grep memcached

echo "Creating crontab for ./exercise-memcached.sh"
echo "* * * * * ./exercise-memcached.sh" | crontab - -u vagrant
crontab -l -u vagrant
