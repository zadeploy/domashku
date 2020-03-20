#!/bin/bash

set -x
set -o errexit
set -o nounset


TOKEN="$CLOUDFLARE_API_TOKEN"
ZONEID="4f70d62b382c30c7f83942a758ed9eac"
FQDN="abitrolly.lab.zadeploy.com"
APIURL="https://api.cloudflare.com/client/v4/zones/$ZONEID/dns_records"

IPADDR="$(ip route get 8.8.8.8 | cut -f 7 -d' ')"

noname () {
  # Returns 1 if name is not present
  echo "[x] Checking if ${FQDN} is already registered.."

  RET=0
  curl -sS -H "Content-Type: application/json" \
       -H "Authorization: Bearer ${TOKEN}" \
       "$APIURL" \
    | jq . | grep -q "$FQDN"  `# returns 1 if no matches` \
    && RET=$? || RET=$?

  # doesn't distinguish between no record and error making request
  return $RET
}

register () {
  echo "[x] Creating record for ${FQDN}.."

  JSON='{
    "type": "A",
    "name":"'"$FQDN"'",
    "content":"'"$IPADDR"'",
    "ttl": 120
  }'

  # It is very very cryptic trying to get status code, output and return
  # code from the same request. Therefore just analysing JSON response
  # for expected results as a success.
  # https://superuser.com/questions/590099/can-i-make-curl-fail-with-an-exitcode-different-than-0-if-the-http-status-code-i
  RES=$(curl -sS -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${TOKEN}" \
	  -d "$JSON" "$APIURL")
  if [[ $RES == *'"success":true"'* ]]; then
    echo -e "Registered ${FQDN} A ${IPADDR}"
  elif [[ $RES == *'"The record already exists."'* ]]; then
    echo -e "The record for ${FQDN} already exist"
  else
    echo "Error registering ${FQDN}"
  fi
}


if [[ noname ]]; then
  register
else
  echo "${FQDN} is already present in DNS records"
fi

