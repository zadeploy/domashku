#!/bin/bash

#Download http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip using shell
wget -v http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip


#Unpack the log file
unzip log20170630.zip

#Change owner of log file to your current user using chown
chown $(whoami):$(whoami) log20170630.csv

#Change set executive bit to a random.sh script using chmod
chmod +x log20170630.csv

#Execute the random.sh script
mkdir log20170630
mv log20170630.csv log20170630/
./log20170630.csv

#Find the file using find
sudo find /usr -type f -name "log20170630.csv"

file=$(find /usr -type f -name "log20170630.csv")
sudo mv $file ./

#Try to look for errors using your favorite editor
# vim log20170630.csv
#/error

#Try to find errors using grep
grep --color  "error" log20170630.csv

#Tail last 500 lines of file
tail -500 log20170630.csv

#Find how many index.htm hits were at 30.06.2017 14:00
grep "2017-06-30,14:00" log20170630.csv | grep index.htm --color

#Find how many index.htm hits were at 30.06.2017 17:00-18:00
grep "2017-06-30,17:\|2017-06-30,18:00" log20170630.csv | grep index.htm 

#Show the number of times each IP shows up in the log – using sort and uniq utilities
cat log20170630.csv | awk -F ',' '{print $1}' | sort | uniq -c | sort -n

#Count all 13.94.212.jdf IP hits us
grep 13.94.212.jdf log20170630.csv | wc -l
