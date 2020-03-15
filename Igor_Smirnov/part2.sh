#!bin/bash

#1 add ubuntu user to adm and root groups using sed
sed -i 's/^root.*/&ubuntu/g' /etc/group
sed -i 's/^adm.*/&,ubuntu/g' /etc/group
sed -i 's/Minsk/Berlin' /etc/timezone
timedatectl set-timezone Europe/Minsk
