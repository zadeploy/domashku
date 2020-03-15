#!/bin/bash

#1 Download using shell
wget http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip

#2 Unpack the log file
unzip log20170630.zip

if [[ ! -d ./log20170630 ]]
then
    mkdir log20170630
fi

mv log20170630.csv ./log20170630/log20170630.csv


#3 Change owner of log file to your current user using chown
chown $USER:$USER log20170630.csv

#4 Change executive bit to a random.sh script using chmod
chmod +x random-picker.sh

#5 Execute the random-picker.sh script
./random-picker.sh

#6 Find the file using find
find / -name log20170630.csv 2> /dev/null

#7 Try to look for errors using your favorite editor
vim /usr/src/linux-raspi2-headers-5.3.0-1014/drivers/staging/greybus/tools/log20170630.csv

#8 Try to find errors using grep ------> error.csv
cat /usr/src/linux-raspi2-headers-5.3.0-1014/drivers/staging/greybus/tools/log20170630.csv | grep error > error.csv

#9 Tail last 500 lines of file ------> tail500.csv
tail -n 500 /usr/src/linux-raspi2-headers-5.3.0-1014/drivers/staging/greybus/tools/log20170630.csv > tail500.csv

#10 Find how many index.htm hits were at 30.06.2017 14:00  ------> 10416
cat /usr/src/linux-raspi2-headers-5.3.0-1014/drivers/staging/greybus/tools/log20170630.csv | grep "2017-06-30,14:00:[0-5][0-9]" | grep "index.htm" | wc -l

#11 Find how many index.htm hits were at 30.06.2017 17:00-18:00 ------>  409996
cat /usr/src/linux-raspi2-headers-5.3.0-1014/drivers/staging/greybus/tools/log20170630.csv | grep "2017-06-30,1[7]:[0-5][0-9]:[0-5][0-9]" | grep "index.htm" | wc -l

#13 Show the number of times each IP shows up in the log – using sort and uniq utilities ------> ip_count.csv
cut -d, -f1 /usr/src/linux-raspi2-headers-5.3.0-1014/drivers/staging/greybus/tools/log20170630.csv | sort | uniq -ic > ip_count.csv

#14 Count all 13.94.212.jdf IP hits us ------> 87313
cat ip_count.csv | grep 13.94.212.jdf | grep -Eo '^[^ ]+'
