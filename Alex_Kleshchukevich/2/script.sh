#!/bin/sh

# /*       _\|/_
#          (o o)
#  +----oOO-{_}-OOo----------------------+
#  |                                     |
#  |               Part 1                |
#  |                                     |
#  +------------------------------------*/

# Download http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip using shell
wget http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip

# Unpack the log file
unzip log20170630.zip

# Change owner of log file to your current user using chown
sudo chown $USER log20170630

# Change set executive bit to a random.sh script using chmod
sudo chmod 777 random_picker.sh 

# Execute the random.sh script
sudo random_picker.sh

# Find the file using find
find /usr -name "log20170639.csv"
# I moved it back with mv

# Try to look for errors using your favorite editor
vi log20170639.csv

# Try to find errors using grep
grep -h ",404.0," log20170630.csv | more

# Tail last 500 lines of file
tail -n 500 log20170630.csv

# Find how many index.htm hits were at 30.06.2017 14:00
grep '2017-06-30,14:00' log20170630.csv | grep -c index.htm
#10416

# Find how many index.htm hits were at 30.06.2017 17:00-18:00
grep '2017-06-30,17' log20170630.csv | grep -c index.htm
#409996

# Show the number of times each IP shows up in the log – using sort and uniq utilities
cut -d ',' -f 1 log20170630.csv | sort | uniq -c 

# Count all 13.94.212.jdf IP hits us
grep -c 13.94.212.jdf log20170630.csv
#87313

# /*       _\|/_
#          (o o)
#  +----oOO-{_}-OOo----------------------+
#  |                                     |
#  |               Part 2                |
#  |                                     |
#  +------------------------------------*/

# Create script which will
#  add ubuntu user to adm and root groups using sed
sudo sed -i 's/^root.*$/&ubuntu/' /etc/group
sudo sed -i 's/^adm.*$/&,ubuntu/' /etc/group

#  Change timezone to Europe/Berlin in /etc/timezone using sed
sudo sed -i "s/.*/Europe\/Berlin/" /etc/timezone 

#  Change timezone to Europe/Minsk using bash shell utilites and apply it using system commands
sudo timedatectl set-timezone Europe/Minsk


# /*       _\|/_
#          (o o)
#  +----oOO-{_}-OOo----------------------+
#  |                                     |
#  |               Part 3                |
#  |                                     |
#  +------------------------------------*/

# Count number of “mv” command paths using pipes and grep for strace ./random.sh
sudo strace ./random_picker.sh  2>&1 | grep -c mv
