#!/bin/bash


set -o errexit
bash -n $0

if [[ $# != 1 ]]
then
		echo "Only 1 argument required (FQDN)"
		exit 1
fi

NAME=$1

API_TOKEN="$API_TOKEN"
ZONE_ID="$ZONE_ID"

declare -a arr
arr=($(cat config.json | jq '.ip, .ttl'))


get_records_list(){
curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
  -H "Authorization: $API_TOKEN"\
  -H "Content-Type: application/json"
}


update_record(){
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$(echo $1 | tr -d '"')" \
  -H "Authorization: $API_TOKEN"\
  -H "Content-Type: application/json" \
   --data '{"type":"A","name":'\"$NAME\"',"content":'$IP',"ttl":'$TTL',"proxied":false}'
}


create_record(){
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "Authorization: $API_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":'\"$NAME\"',"content":'$IP',"ttl":'$TTL',"priority":10,"proxied":false}'
}


main(){
arr="$1"

IP=${arr[0]}
TTL=${arr[1]}

if [[ $TTL != 1 ]]
then
		echo "TTL should be low (1) now $TTL"
		exit 1
fi

all_records=$(get_records_list)
record=$(echo $all_records | jq ".result[] | select(.name == \"$NAME\" )")

if [ ! -z "$record" ]
then
		ip=$(echo $record | jq ".content")
		if [ $ip != $IP ]
		then
				id=$(echo $record | jq ".id")
				update_record $(echo $record | jq ".id") 2>&1 > /dev/null
				echo " Record updated"
		else
				echo "The record already exists"
				exit 1
		fi
else
		create_record 2>&1 > /dev/null
		echo "Record created"
fi

}

main $arr
