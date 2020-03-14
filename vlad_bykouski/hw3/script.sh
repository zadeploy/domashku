#!/bin/bash
sed -i -e 's/^adm.*/&,ubuntu/g' /etc/group
sed -i -e 's/^root.*/&,ubuntu/g' /etc/group
sed -i -e 's+.*+Europe/Berlin+1' /etc/timezone
timedatectl set-timezone Europe/Minsk
