#!/bin/bash
###find arya.ns.cloudflare.com###
if cat ./test.txt | grep arya.ns.cloudflare.com > /dev/null
then 
echo "The record arya.ns.cloudflare.com already exists"
else
echo "arya.ns.cloudflare.com" >> ./test.txt
echo "The record arya.ns.cloudflare.com add"
fi

###find nchance.ns.cloudflare.com###
if cat ./test.txt | grep nchance.ns.cloudflare.com > /dev/null
then 
echo "The record nchance.ns.cloudflare.com already exists"
else
echo "nchance.ns.cloudflare.com" >> ./test.txt
echo "The record nchance.ns.cloudflare.com add"
fi
