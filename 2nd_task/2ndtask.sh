#!/bin/bash

add_group="1.   "
sed_timezone="2.   "
util_timezone="3.   "
default_exit="0.  "

echo "========================================================="
echo "==                      Choose :                       =="
echo "== 1. Add ubuntu user to adm and root groups using sed =="
echo "== 2. Change timezone to Berlin using sed              =="
echo "== 3. Change timezone to Minsk with utilities          =="
echo "== 0. Exit                                             =="
echo "========================================================="
echo "   Your choise: "


add_group (){
read -p 'Instert groups file: ' filegrp

lasts=`echo $catgr | awk -F: '{print $NF}'`
adgr=$(cat group | grep ^adm)
rogr=$(cat group | grep ^root)


for i in $adgr; do
for j in $rogr; do
	ladgr=$(echo $i | awk -F: '{print $NF}')
	lrogr=$(echo $j | awk -F: '{print $NF}')
	
if [[ -n $lrogr ]]
then 
	echo "Nothing to do"
else
	sed -i '/^root/s/$/ubuntu/' $filegrp
fi

if	[[ -n $ladgr ]]
then 
	sed -i '/^adm/s/$/,ubuntu/' $filegrp
fi

done; done
}

sed_timezone (){
sed -i 's/Minsk/Berlin/g' /etc/timezone
}

util_timezone (){
timedatectl set-timezone Europe/Minsk
}

read choise
case "$choise" in
        1|a) add_group;;            
        2|b) sed_timezone;;
        3|c) util_timezone;;
        0|z) exit;;
esac
