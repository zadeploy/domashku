#!/bin/bash

echo "Enter username"
read USER
sed -i "/adm:/s/$/,$USER/; /root:/s/$/,$USER/" /etc/group
echo "User $USER added to groups ADM and ROOT"

sed -i '1c\Europe/Berlin' /etc/timezone
echo "The timezone changed to Europe/Berlin"

timedatectl set-timezone Europe/Minsk
echo "The timezone changed to Europe/Minsk"
