#!/bin/bash

#set -x
set -o errexit
set -o nounset


TOKEN="$CLOUDFLARE_API_TOKEN"
ZONEID="4f70d62b382c30c7f83942a758ed9eac"
FQDN="abitrolly.lab.zadeploy.com"
APIURL="https://api.cloudflare.com/client/v4/zones/$ZONEID/dns_records"

IPADDR="$(ip route get 8.8.8.8 | cut -f 7 -d' ')"


RECORDID=

registered () {
  # Returns 1 if registered, 0 if not.
  # Returns 2 if IP is wrong and sets RECORDID.
  echo -e "[x] Checking if ${FQDN} is already registered.."

  OUT=$(curl -sS -H "Content-Type: application/json" \
       -H "Authorization: Bearer ${TOKEN}" \
       "$APIURL")

  if [[ $OUT == *"$FQDN"* ]]; then
    REGIP=$(grep -Po "\"${FQDN}\",\"content\":\"\K.*?(?=\")" <<< "$OUT")
    if [[ "$REGIP" == "$IPADDR" ]]; then
      return 1
    else
      echo "IP ${REGIP} doesn't match local ${IPADDR}"
      ID=$(grep -Po '"id":"\K.*?(?=","type":"A","name":"'"${FQDN}"'")' <<< "$OUT")
      # there could be more than one record, return only the first
      if [[ "$ID" =~ [[:space:]]+ ]]; then
	 ARRID=($ID)
	 RECORDID=${ARRID[0]}
      else
	 RECORDID=$ID
      fi
      return 2
    fi
  fi
  return 0
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
  echo "$RES"
  if [[ $RES == *'"success":true,'* ]]; then
    echo -e "Registered ${FQDN} A ${IPADDR}"
  elif [[ $RES == *'"The record already exists."'* ]]; then
    echo -e "The record ${FQDN} A ${IPADDR} already exists."
  else
    echo "Error registering ${FQDN}"
  fi
}

remove () {
 echo "[x] Removing record for ${FQDN} with ID ${RECORDID}.."

 RES=$(curl -sS -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${TOKEN}" \
	  -X DELETE "$APIURL"/"$RECORDID")
 echo $RES
}


registered && REGD=$? || REGD=$?
if [[ $REGD == 1 ]]; then
  echo "${FQDN} A ${IPADDR} is already in DNS records"
else
  if [[ $REGD == 2 ]]; then
    remove
  fi
  register
fi

