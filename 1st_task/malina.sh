#!/bin/bash
tcLtR="\033[01;31m"    
tcLtGRN="\033[01;32m"  
tcLtC="\033[01;36m"    
tcW="\033[01;37m"      
tcDkG="\033[01;30m"    
tcORANGE="\033[38;5;209m"
tcLtP="\033[01;35m"   

HOUR=$(date +"%H")
if [ $HOUR -lt 12  -a $HOUR -ge 0 ]; then TIME="morning"
elif [ $HOUR -lt 17 -a $HOUR -ge 12 ]; then TIME="afternoon"
else TIME="evening"
fi

clear

burn_image="1.  "
add_configs="2.  "
default_exit="0.  "

cat mk.txt | lolcat
echo -e $tcDkG "=============================="
echo -e $tcLtG " Good $TIME ! $tcORANGE Van der Graum"
echo -e $tcDkG "=============================="
echo -e $tcLtR "     Choose your destiny:"
echo -e $tcW   "1. $tcLtP Burn image"
echo -e $tcW   "2. $tcLtC Add configs"
echo -e $tcW   "0. $tcLtGRN Exit"
echo -e $tcDkG "=============================="                                 
echo -e $tcLtR "   Your choise: "


burn_image (){
read -p 'Path to your image: ' isopath
read -p 'Path to your device: ' devicepath

echo $isopath $devicepath
xzcat $isopath | sudo dd of=$devicepath status=progress
}

add_configs (){
read -p 'Path to root partition: ' rootpart
read -p 'Path to boot partition: ' bootpart
read -p 'Mount point root: ' mpoint
read -p 'Mount point system-boot: ' mpointboot

sudo mount $rootpart $mpoint && sudo mount $bootpart $mpointboot

echo graumpi | sudo tee $mpoint/etc/hostname
echo "127.0.0.1 graumpi" | sudo tee -a $mpoint/etc/hosts

sudo touch $mpointboot/ssh

read -p 'Wi-Fi SSID: ' wsid
read -s -p 'Wi-Fi password: ' wpass

cat <<EOF | sudo tee $mpoint/etc/wpa_supplicant/wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=ubuntu
country=BY

network={
        ssid="$wsid"
        scan_ssid=1
        key_mgmt=WPA-PSK
        psk="$wpass"
}
EOF

echo "@reboot	root	/bin/bash /etc/onwifi.sh" | sudo tee -a $mpoint/etc/crontab

cat <<EOF | sudo tee $mpoint/etc/onwifi.sh
#!/bin/bash

# Searching for exicting wpa processes and kill them
ps aufx | grep wpa | grep -v grep | awk '{print $2}' | xargs kill 2> /dev/null

sleep 10

# Start wpa_supplicant and getting local IP
wpa_supplicant -B -c /etc/wpa_supplicant/wpa_supplicant.conf -i wlan0

sleep 10

dhclient

# Install network-manager

#apt -y install network-manager

#sleep 20

#systemctl enable NetworkManager.service
#systemctl start NetworkManager.service
#nmcli device wifi connect AndroidAP password Andryxa125

#sed -i -e 's|@reboot|#@reboot|g' /etc/crontab
EOF


sudo umount $mpoint && sudo umount $mpointboot
}

read destiny
case "$destiny" in
        1|a) burn_image;;            
        2|b) add_configs;;
        0|z) exit;;
esac

