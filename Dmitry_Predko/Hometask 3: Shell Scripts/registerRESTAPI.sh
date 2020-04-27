#!/bin/bash

# api token: gqAEvi3cCcEmWtsyjAVu_VFE8kfy58TYNHQPatd5
# zone id: 4f70d62b382c30c7f83942a758ed9eac

# Check token
#`curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
#-H "Authorization: Bearer gqAEvi3cCcEmWtsyjAVu_VFE8kfy58TYNHQPatd5" \
#-H "Content-Type:application/json"`

# Sample to check the zone 
#`curl -X GET "https://api.cloudflare.com/client/v4/zones/4f70d62b382c30c7f83942a758ed9eac" \
#       -H "Content-Type: application/json" \
#       -H "Authorization: Bearer gqAEvi3cCcEmWtsyjAVu_VFE8kfy58TYNHQPatd5"`

# Sample to create test1.lab.zadeploy.com fqdn
#`curl -X POST "https://api.cloudflare.com/client/v4/zones/4f70d62b382c30c7f83942a758ed9eac/dns_records" \
#       -H "Authorization: Bearer gqAEvi3cCcEmWtsyjAVu_VFE8kfy58TYNHQPatd5"\
#       -H "Content-Type: application/json" \
#       --data '{"type":"A","name":"predko.lab.zadeploy.com","content":"127.0.0.1","ttl":120,"priority":10,"proxied":false}'`


#Sample to list zone
#`curl -X GET "https://api.cloudflare.com/client/v4/zones/4f70d62b382c30c7f83942a758ed9eac/dns_records?type=A&name=predko.lab.zadeploy.com" \
#       -H "Authorization: Bearer gqAEvi3cCcEmWtsyjAVu_VFE8kfy58TYNHQPatd5"\
#       -H "Content-Type: application/json" `

IP=`dig @arya.ns.cloudflare.com $HOSTNAME.lab.zadeploy.com +short`
LOCIP=`hostname -i | cut -d' ' -f1`
ID=$(curl -X GET "https://api.cloudflare.com/client/v4/zones/4f70d62b382c30c7f83942a758ed9eac/dns_records?type=A&name=$HOSTNAME.lab.zadeploy.com" \
       -H "Authorization: Bearer gqAEvi3cCcEmWtsyjAVu_VFE8kfy58TYNHQPatd5"\
       -H "Content-Type: application/json" | grep -Po '"id":".*?[^\\]"' |  sed -e 's/.*"\(.*\)".*/\1/')

if [ $? -eq 0 ]; then
        echo "The record $HOSTNAME.lab.zadeploy.com already exists with ip = $IP "
        if [ "$IP" == "$LOCIP" ]; then
                echo "The A-record is up to date"
        else
              curl -X PUT "https://api.cloudflare.com/client/v4/zones/4f70d62b382c30c7f83942a758ed9eac/dns_records/$ID" \
                -H "Authorization: Bearer gqAEvi3cCcEmWtsyjAVu_VFE8kfy58TYNHQPatd5"\
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"'"$HOSTNAME"'.lab.zadeploy.com","content":"'"$LOCIP"'","ttl":120,"proxied":false}'
fi;
else
        curl -X POST "https://api.cloudflare.com/client/v4/zones/4f70d62b382c30c7f83942a758ed9eac/dns_records" \
                -H "Authorization: Bearer gqAEvi3cCcEmWtsyjAVu_VFE8kfy58TYNHQPatd5"\
                -H "Content-Type: application/json" \
                --data '{"type":"A","name":"'"$HOSTNAME"'.lab.zadeploy.com","content":"'"$LOCIP"'","ttl":120,"priority":10,"proxied":false}'
fi;

