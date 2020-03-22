#!/bin/bash

set -o errexit
set -o nounset
DNS_NAME=$1
IP=$2
create_dns_record()  {
    curl -X POST "https://api.cloudflare.com/client/v4/zones/ea1dc8f4bcbaa356fd80978d23989450/dns_records" \
        -H "Authorization: Bearer OgeV_r5CwiDT2IYzkZNsZLXmBJz8F3diW4zaKLcr" \
        -H "Content-Type: application/json" \
        --data '{"type":"A","name":"'"$DNS_NAME"'","content":"'"$IP"'","ttl":120,"priority":10,"proxied":true}'
            
}

create_dns_record
