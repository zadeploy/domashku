#!/bin/bash

if [ -z $(cat /etc/resolv.conf | grep 'arya.ns.cloudflare.com') ]
then
		echo "arya.ns.cloudflare.com" >> /etc/resolv.conf
fi

if [ -z $(cat /etc/resolv.conf | grep 'chance.ns.cloudflare.com') ]
then
		echo "chance.ns.cloudflare.com" >> /etc/resolv.conf
fi
