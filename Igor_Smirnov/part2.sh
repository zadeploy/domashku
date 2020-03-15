#!bin/bash

#1 add ubuntu user to adm and root groups using sed
sed -i 's/^root.*/&ubuntu/g' /etc/group
sed -i 's/^adm.*/&,ubuntu/g' /etc/group

#2 Change timezone to Europe/Berlin in /etc/timezone using sed
sed -i 's/Minsk/Berlin' /etc/timezone

#3 Change timezone to Europe/Minsk using bash shell utilites and apply it using system commands
timedatectl set-timezone Europe/Minsk
