#!/bin/bash

function write_img {
#Записываем образ диска на флешку
echo "Записать образ на флешку?(y/n)"
read item
echo "Укажите путь к образу системы в формате img.xz"
read dir
case "$item" in
        y|Y) xzcat $dir | sudo dd of=$b status=progress;;
        *) echo "Действие по умолчанию - не записывать";;
esac
}

function umount_common {	
	df -h | grep "/dev/mmc*" |grep -iv "Ошибка"| awk '{print $6}' | xargs umount
	echo "Флешка отмонтирована от дисковой системы"
}

function cron_add {
	touch -c /media/catherine/raspberry/root/wi_fi.sh
	echo "ps aufx | grep wpa| grep -v grep| awk '{print \$2}'| xargs kill && wlan=\$(ip a | grep 3: | awk '{print \$2}' | sed 's/://g') && wpa_supplicant -B -c /etc/wpa_supplicant/wpa_supplicant.conf -i \$wlan && dhclient \$wlan && touch -c /boot/ssh">/media/catherine/raspberry/root/wi_fi.sh
	chmod +x /media/catherine/raspberry/root/wi_fi.sh
#	echo ` cat /media/catherine/raspberry/root/wi_fi.sh`
	
	cr=$(cat /media/catherine/raspberry/etc/crontab | grep "ubuntu" | wc -l  )
	case "$cr" in
		0) echo "@reboot root /bin/bash /root/wi_fi.sh" >> /media/catherine/raspberry/etc/crontab
			echo "Cron-задание на запуск wi-fi добавлено";;
		*) echo "Задание cron было добавлено ранее";;
	esac
}

function wifi_add {
	echo "Вы хотите добавить новую wi-fi сеть? [y/n]"
	read wi
	case "$wi" in
		y|Y) add_wifi;;
		*) ;;
	esac
}

function add_wifi {
	echo "Введите имя wi-fi сети"
        read name
        echo "Введите пароль к wi-fi сети"
        read pass
	echo "network={
    ssid=\"$name\"
    psk=\"$pass\"
    scan_ssid=1
    key_mgmt=WPA-PSK
    id_str=\"$name\"
}" >>/media/catherine/raspberry/etc/wpa_supplicant/wpa_supplicant.conf

cat /media/catherine/raspberry/etc/wpa_supplicant/wpa_supplicant.conf
}

function beginning {
#Находим имя диска
b=$(lsblk -d /dev/mm* | head -2| tail -1 |awk '{print $1}')

#Размонтируем флешку
umount_common

#Записываем изображение диска
write_img

#Примонтируем флешку обратно
a2=$(fdisk -l | grep "/dev/mm*"|head -2| tail -1|awk '{print $1}')
mount $a2 /media/catherine/sys-boot
b2=$(fdisk -l | grep "/dev/mm*"|head -3| tail -1|awk '{print $1}')
mount $b2 /media/catherine/raspberry


touch -c /media/catherine/raspberry/etc/wpa_supplicant/wpa_supplicant.conf
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=ubuntu
update_config=1
country=BY
network={
    ssid=\"rubizza\"
    psk=\"rubizza2019\"
    key_mgmt=WPA-PSK
    scan_ssid=1
    id_str=\"zadeploy\"
}" > /media/catherine/raspberry/etc/wpa_supplicant/wpa_supplicant.conf

echo "Конфигурация Wi-Fi успешно записана"
wifi_add

#cat /media/catherine/raspberry/etc/wpa_supplicant/wpa_supplicant.conf

hosts_=$(cat /media/catherine/raspberry/etc/hosts | grep "cherednichenko"|wc -l)

case "$hosts_" in
	0) echo "127.0.0.1 cherednichenko" >> /media/catherine/raspberry/etc/hosts;;
	*) echo "hostname уже был добавлен в /etc/hosts"
esac

echo "cherednichenko" > /media/catherine/raspberry/etc/hostname

cp /media/catherine/raspberry/etc/wpa_supplicant/wpa_supplicant.conf /media/catherine/sys-boot/wpa_supplicant.conf
touch /media/catherine/sys-boot/ssh
touch /media/catherine/raspberry/etc/ssh /media/catherine/raspberry/boot/ssh



cron_add
echo "Завершено добавление cron-задания"
}



testing=$(df -h |grep "/dev/mmc*"|wc -l)

case "$testing" in 
	0) echo "SD-карта не подключена!";;
	[1-9]) beginning;;
	*) echo "Something is wrong. 0_o"
esac
