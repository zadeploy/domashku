#!/bin/bash

set -x
set -o errexit
set -o nounset

echo "[x] Add Cloudflare DNS to /etc/resolv.conf"
grep -q "ns.cloudflare.com" /etc/resolv.conf || \
	(echo "arya.ns.cloudflare.com" >> /etc/resolv.conf; \
	 echo "chance.ns.cloudflare.com" >> /etc/resolv.conf)
