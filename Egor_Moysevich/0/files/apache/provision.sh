#!/bin/bash

cp /tmp/site.conf /etc/apache2/sites-available/site.conf > /dev/null
cp /tmp/site-ssl.conf /etc/apache2/sites-available/site-ssl.conf > /dev/null
cp /tmp/site-selfsigned.crt /etc/ssl/certs/site-selfsigned.crt > /dev/null
cp /tmp/site-selfsigned.key /etc/ssl/private/site-selfsigned.key > /dev/null

a2enmod ssl > /dev/null # enabling ssl mod
a2enmod rewrite > /dev/null # enabling rewrite mode to force https redirection
a2ensite site-ssl.conf > /dev/null # enabling https config
a2ensite site.conf > /dev/null # enabling http config

service apache2 restart > /dev/null # restarting apache to apply configuration
echo 'apache is ok'
