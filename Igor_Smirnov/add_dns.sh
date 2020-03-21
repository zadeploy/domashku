#!/bin/bash

#set -x

if [[ $(cat /etc/resolv.conf | grep 'arya.ns.cloudflare.com\|chance.ns.cloudflare' | wc -l) -ne 2 ]]
then
		echo -e "arya.ns.cloudflare.com\nchance.ns.cloudflare.com" >> /etc/resolv.conf
else
		echo "DNS already exists"
fi
