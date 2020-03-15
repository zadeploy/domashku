#!/bin/bash

# add ubuntu user to adm and root groups using sed
sed -i 's/^adm.*/&,ubuntu/g' /etc/group
sed -i 's/^root.*/&ubuntu/g' /etc/group

# Change timezone to Europe/Berlin in /etc/timezone using sed
sudo sed -i 's/Minsk/Berlin/' /etc/timezone

# Change timezone to Europe/Minsk using bash shell utilites and apply it using system commands
sudo timedatectl set-timezone Europe/Minsk
