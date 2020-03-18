#!/bin/bash

IP1=`dig @1.1.1.1 arya.ns.cloudflare.com +short`
IP2=`dig @1.1.1.1 chance.ns.cloudflare.com +short`
echo -e "arya.ns.cloudflare.com $IP1 \nchance.ns.cloudflare.com $IP2" | tee -a /etc/resolv.conf                  
