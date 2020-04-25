#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/smirnovcv.com.key -out /etc/ssl/certs/smirnovcv.com.crt -batch 2>/dev/null
