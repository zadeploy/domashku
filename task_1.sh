#!/bin/bash

# Download http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip using shell
wget http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip

# Unpack the log file
unzip log20170630.zip

# Change owner of log file to your current user using chown
chown -R $(whoami) log20170630.csv

# Change set executive bit to a random.sh script using chmod
chmod +x random_picker.sh

# Execute the random.sh script
sudo sh random_picker.sh

# Find the file using find
sudo find / -iname 'log20170630.csv'

# Try to look for errors using your favorite editor
nano /usr/share/icons/hicolor/22x22/log20170630.csv

# Try to find errors using grep
cat /usr/share/icons/hicolor/22x22/log20170630.csv | grep error -c

# Tail last 500 lines of file
tail -n 500 /usr/share/icons/hicolor/22x22/log20170630.csv

# Find how many index.htm hits were at 30.06.2017 14:00
cat /usr/share/icons/hicolor/22x22/log20170630.csv | grep 2017-06-30,14:00 | grep index.htm -c

# Find how many index.htm hits were at 30.06.2017 17:00-18:00
cat /usr/share/icons/hicolor/22x22/log20170630.csv | grep 2017-06-30,17:[0-5][0-9]:[0-5][0-9] | grep index.htm -c

# Show the number of times each IP shows up in the log – using sort and uniq utilities
cut -d, -f1 /usr/share/icons/hicolor/22x22/log20170630.csv | sort | uniq -ic

# Count all 13.94.212.jdf IP hits us
cat /usr/share/icons/hicolor/22x22/log20170630.csv | grep 13.94.212.jdf -c
