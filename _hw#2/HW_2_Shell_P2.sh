#!/bin/bash

#add ubuntu user to adm and root groups using sed  
sed -i '/^root:/s/$/ubuntu/' /etc/group 
sed -i '/^adm:/s/$/,ubuntu/' group 
#Change timezone to Europe/Berlin in /etc/timezone using sed 
sed -i 's/^.*$/Europe\/Berlin/' /etc/timezone 

#Change timezone to Europe/Minsk using bash shell utilites and apply it using system commands 
timedatectl set-timezone Europe/Minsk
