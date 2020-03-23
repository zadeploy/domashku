#!/bin/bash

set -o errexit
set -o nounset

AUTH_TOKEN=
ZONE_ID=
CONTENT=127.0.0.1

VERIFY_TOKEN=$(curl --silent -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
 -H "Authorization: Bearer $AUTH_TOKEN" \
 -H "Content-Type:application/json")

VERIFY_SUCCESS=$(echo $VERIFY_TOKEN | grep -Po '"success":*\K[^,]*')

if [[ $VERIFY_SUCCESS == false ]] ; then
  VERIFY_ERRORS=$(echo $VERIFY_TOKEN | grep -Po '"errors":\[*\K[^\]]*')
  echo "Errors: $VERIFY_ERRORS"
  exit 1
fi

get_dns_record () {
  local FQDN=$1
  local URL="https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?type=A&name=$FQDN"
  local RESPONSE=$(curl --silent -X GET "$URL" \
   -H "Authorization: Bearer $AUTH_TOKEN" \
   -H "Content-Type:application/json")

  local RESPONSE_COUNT=$(echo $RESPONSE | grep -Po '"count":*\K[^,]*')

  DNS_RECORD_ID=$(echo $RESPONSE | grep -Po '"id":"*\K[^"]*' || true)
  DNS_CONTENT=$(echo $RESPONSE | grep -Po '"content":"*\K[^"]*' || true)

  if [[ $RESPONSE_COUNT != 0 ]] ; then
    echo "The record already exists: id=$DNS_RECORD_ID content=$DNS_CONTENT name=$FQDN"
  else
    echo "No record found with name=$FQDN"
  fi
}

patch_dns_record () {
  local FQDN=$1
  local URL="https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID"
  local RESPONSE=$(curl --silent -X PATCH "$URL" \
   -H "Authorization: Bearer $AUTH_TOKEN" \
   -H "Content-Type:application/json" \
   --data "{\"content\":\"$CONTENT\"}")

  local NEW_DNS_RECORD_ID=$(echo $RESPONSE | grep -Po '"id":"*\K[^"]*')
  local NEW_DNS_CONTENT=$(echo $RESPONSE | grep -Po '"content":"*\K[^"]*')

  RESPONSE_SUCCESS=$(echo $RESPONSE | grep -Po '"success":*\K[^,]*')
  if [[ $RESPONSE_SUCCESS == true ]] ; then
    echo "Successfully updated dns record: id=$NEW_DNS_RECORD_ID content=$NEW_DNS_CONTENT"
    exit 0
  else
    local ERRORS=$(echo $RESPONSE | grep -Po '"errors":\[*\K[^\]]*')
    echo "Errors: $ERRORS"
    exit 1
  fi
}

post_dns_record () {
local FQDN=$1
local PAYLOAD=$(cat <<EOF
{
  "type":"A",
  "name":"$FQDN",
  "content":"$CONTENT",
  "ttl":1,
  "priority":10,
  "proxied":false
}
EOF
)

  local RESPONSE=$(curl --silent -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
    -H "Authorization: Bearer $AUTH_TOKEN" \
    -H "Content-Type: application/json" \
   --data "$PAYLOAD")

  local RESPONSE_SUCCESS=$(echo $RESPONSE | grep -Po '"success":*\K[^,]*')

  local NEW_DNS_RECORD_ID=$(echo $RESPONSE | grep -Po '"id":"*\K[^"]*')
  local NEW_DNS_CONTENT=$(echo $RESPONSE | grep -Po '"content":"*\K[^"]*')

  if [[ $RESPONSE_SUCCESS == true ]] ; then
    echo "Successfully created dns record: id=$NEW_DNS_RECORD_ID content=$NEW_DNS_CONTENT"
    exit 0
  else
    local ERRORS=$(echo $RESPONSE | grep -Po '"errors":\[*\K[^\]]*')
    echo "Errors: $ERRORS"
    exit 1
  fi
}


register_pi_name () {
  local FQDN=$1

  if [[ -z "$FQDN" ]]; then
    echo "No argument supplied"
    exit 1
  fi

  get_dns_record $FQDN

  if [[ $DNS_RECORD_ID ]] && [[ $DNS_CONTENT == $CONTENT ]]; then
    echo "DNS record is in the correct state. Exiting..."
    exit 0
  fi

  if [[ $DNS_RECORD_ID ]] && [[ $DNS_CONTENT != $CONTENT ]]; then
    echo "Need to update IP"
    patch_dns_record $FQDN
  fi

  post_dns_record $FQDN
}

register_pi_name "kleshchukevich.lab.zadeploy.com"
