#!/bin/bash

cp /tmp/site.conf /etc/apache2/sites-available/site.conf > /dev/null
a2ensite site.conf > /dev/null

echo "Hi, I don't do anything right now. I'm just an example of how to do basic provisioning with shell scripts."
service apache2 stop  1>&2 > /dev/null  # I lied