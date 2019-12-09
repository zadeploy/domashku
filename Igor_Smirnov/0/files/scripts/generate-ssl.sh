#!/bin/bash

DOMAIN="localhost"

# Generate a passphrase
export PASSPHRASE=$(head -c 500 /dev/urandom | tr -dc a-z0-9A-Z | head -c 128; echo)

# Certificate details
subj="
C=EU
ST=OR
O=Kek
localityName=JKVWKJ
commonName=$DOMAIN
organizationalUnitName=OWFAWF
emailAddress=ya@admin.com
"

# Generate the server private key
openssl genrsa -des3 -out /etc/ssl/private/$DOMAIN.key -passout env:PASSPHRASE 2048 > /dev/null 2>&1


# Generate the CSR
openssl req \
    -new \
    -batch \
    -subj "$(echo -n "$subj" | tr "\n" "/")" \
    -key /etc/ssl/private/$DOMAIN.key \
    -out /etc/ssl/private/$DOMAIN.csr \
    -passin env:PASSPHRASE


cp /etc/ssl/private/$DOMAIN.key /etc/ssl/private/$DOMAIN.key.org


# Strip the password so we don't have to type it every time we restart Apache
openssl rsa -in /etc/ssl/private/$DOMAIN.key.org -out /etc/ssl/private/$DOMAIN.key -passin env:PASSPHRASE > /dev/null 2>&1


# Generate the cert
openssl x509 -req -days 365 -in /etc/ssl/private/$DOMAIN.csr -signkey /etc/ssl/private/$DOMAIN.key -out /etc/ssl/certs/$DOMAIN.crt > /dev/null 2>&1

echo "SSL Certificate created"
