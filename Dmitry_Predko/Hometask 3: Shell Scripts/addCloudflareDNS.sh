#!/bin/bash

DNS1=arya.ns.cloudflare.com
DNS2=chance.ns.cloudflare.com

IP1=`dig @1.1.1.1 arya.ns.cloudflare.com +short`
IP2=`dig @1.1.1.1 chance.ns.cloudflare.com +short`

for i in $DNS1 $DNS2
do
        grep -o $i /etc/resolv.conf >> /dev/null
        if [ $? -eq 0 ]; then
                if [ $i == $DNS1 ]; then
                        if [ `grep $i /etc/resolv.conf | cut -d" " -f2` == $IP1 ]; then
                                echo "$DNS1 is OK"
                        else
                                sed -i 's/'"$DNS1"'.*/'"$DNS1 $IP1"'/g' /etc/resolv.conf
                        fi
                else
                        if [ `grep $i /etc/resolv.conf | cut -d" " -f2` == $IP2 ]; then
                                echo "$DNS2 is OK"
                        else
                                sed -i 's/'"$DNS2"'.*/'"$DNS2 $IP2"'/g' /etc/resolv.conf
                        fi
                fi
        else
                if [ $i == $DNS1 ]; then
                        echo -e "$DNS1 $IP1" >> /etc/resolv.conf
                else
                        echo -e "$DNS2 $IP2" >> /etc/resolv.conf
                fi
        fi
done
                
