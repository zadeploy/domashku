#!/bin/bash

#Create script which will
#add ubuntu user to adm and root groups using sed
#Change timezone to Europe/Berlin in /etc/timezone using sed
#Change timezone to Europe/Minsk using bash shell utilites and apply it using system commands

function add_user {
	cp /etc/group ./
	file=group
#	echo "Введите путь к файлу groups"
#	read file
	
	a1=$(grep "adm:" $file| tr \: ' ' | wc -w)
	
	case "`grep "adm:" $file| tr \: ' ' | wc -w`" in
		3) sed -i '/^adm:/s/$/ubuntu/' $file ;;
		4) sed -i '/^adm:/s/$/,ubuntu/' $file ;;
	esac
	
	case "$(grep "root:" $file| tr \: ' ' | wc -w)" in
        	3) sed -i '/^root:/s/$/ubuntu/' $file ;;
        	4) sed -i '/^root:/s/$/,ubuntu/' $file ;;
	esac
	cat $file
	start_script
}


function timezone_1 {
	#Редактирование файла timezone не рекомендуется во избежание последствий криворукости
	cp /etc/timezone ./
	timez="timezone"
	zone=$(cat $timez)
	nzone="Europe/Berlin"
	sed -i -e 's|'$zone'|'$nzone'|g' $timez
	cat $timez
}


function timezone_2 {
	timedatectl set-timezone Europe/Minsk
	timedatectl
}



function start_script {
	echo -e "\e[34m============================================================\e[0m"
	echo "[1] Добавить пользователя ubuntu в группы adm и root"
	echo "[2] Сменить часовой пояс на Europe/Berlin"
	echo "[3] Сменить часовой пояс на Europe/Minsk"
	echo "[0] Выход"
	echo -e "\e[34m============================================================\e[0m"
	read item
	case "$item" in 
		1) add_user
			start_script;;
		2)timezone_1 
			start_script;;
		3)timezone_2
			start_script;;
		0) exit 0;;
		*) start_script;;
	esac
}



start_script
