#!/bin/bash


sed -i 's/^adm.*/&,bardatky/g' /etc/group
sed -i 's/^root.*/&,bardatky/g' /etc/group

sudo sed -i 's/Minsk/Berlin/g' /etc/timezone

sudo timedatectl set-timezone Europe/Minsk
