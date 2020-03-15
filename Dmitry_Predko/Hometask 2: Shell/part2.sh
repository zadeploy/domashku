#!/bin/bash

echo "Enter username"
read USER
sed -i "/adm:/s/$/,$USER/; /root:/s/$/,$USER/" /etc/group

echo "User $USER added to groups ADM and ROOT"
