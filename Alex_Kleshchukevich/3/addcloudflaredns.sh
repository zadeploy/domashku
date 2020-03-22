#!bin/bash

set -o errexit
set -o nounset

ARYA="arya.ns.cloudflare.com"
CHANCE="chance.ns.cloudflare.com"

addDns () {
  if grep -q "$1" /etc/resolv.conf ; then
    echo "$1 is already present in the file"
  else
    echo "$1" >> /etc/resolv.conf
    echo "$1 added"
  fi
}

addDns $ARYA
addDns $CHANCE
