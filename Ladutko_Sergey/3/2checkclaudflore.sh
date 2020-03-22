#!/bin/bash
MY_TOCKEN=
IP=
if curl -X POST "https://api.cloudflare.com/client/v4/zones/ea1dc8f4bcbaa356fd80978d23989450/dns_records" \
      -H "Authorization: Bearer $MY_TOCKEN" \
      -H "Content-Type: application/json" \
      --data '{"type":"A","name":"homework.sergeyladutko.xyz","content":"'"$IP"'","ttl":120,"priority":10,"proxied":true}' | grep -w "The record already exists" >> /dev/null
then 
echo "The record already exists"     
else
echo "create dns records in  cloudflare.com"
fi
############CHECKIP###################
if curl -X GET "https://api.cloudflare.com/client/v4/zones/ea1dc8f4bcbaa356fd80978d23989450/dns_records?type=A&name=homework.sergeyladutko.xyz&content=136.243.91.3&page=1&per_page=20&order=type&direction=desc&match=all" \
      -H "Authorization: Bearer OgeV_r5CwiDT2IYzkZNsZLXmBJz8F3diW4zaKLcr" \
      -H "Content-Type: application/json" | grep -w $IP >> /dev/null
then 
echo "The record is valid and ready to go"     
else
curl -X PUT "https://api.cloudflare.com/client/v4/zones/ea1dc8f4bcbaa356fd80978d23989450/dns_records/13084c7f88d2e43c8fc5c4fd4c12e183" \
      -H "Authorization: Bearer OgeV_r5CwiDT2IYzkZNsZLXmBJz8F3diW4zaKLcr" \
      -H "Authorization: Bearer $MY_TOCKEN" \
      --data '{"type":"A","name":"homework.sergeyladutko.xyz","content":"'"$IP"'","ttl":120,"priority":10,"proxied":true}'
echo "The record is update"
fi
