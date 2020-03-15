#!/bin/bash

# Download http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip using shell
URL="http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip"
FILENAME="$(basename $URL)"

# download only if there is no file
[[ -f $FILENAME ]] || curl -#LO "$URL"
# -#  sane progress bar
# -L  follow redirects
# -O  download as a file


# Unpack the log file
NAME="$(basename $FILENAME .zip)"
[[ -f $NAME.csv ]] || unzip "$FILENAME"


# Change owner of log file to your current user using chown

# Change set executive bit to a random.sh script using chmod

# Execute the random.sh script

# Find the file using find

# Try to look for errors using your favorite editor

# Try to find errors using grep

# Tail last 500 lines of file

# Find how many index.htm hits were at 30.06.2017 14:00

# Find how many index.htm hits were at 30.06.2017 17:00-18:00

# Show the number of times each IP shows up in the log – using sort and uniq utilities

# Count all 13.94.212.jdf IP hits us
