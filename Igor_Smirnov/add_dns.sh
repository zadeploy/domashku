#!/bin/bash

if [ $(cat /etc/hosts | grep ' smirnovcv.com' | wc -l) -eq 0 ]
then
		echo "127.0.0.1 smirnovcv.com" >> /etc/hosts
fi

if [ $(cat /etc/hosts | grep ' admin.smirnovcv.com' | wc -l) -eq 0 ]
then
		echo "127.0.0.1 admin.smirnovcv.com" >> /etc/hosts
fi
