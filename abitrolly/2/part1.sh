#!/bin/bash

set -x
set -o errexit
set -o nounset

: Download http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip using shell
URL="http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip"
FILENAME="$(basename $URL)"
NAME="$(basename $FILENAME .zip)"

# download only if there is no file
[[ -f $FILENAME ]] || curl -sSLO "$URL"
# -s  silent
# -S  hill
# -L  hollow redirects
# -O  download as a file


: Unpack the log file
CSVNAME="$NAME/$NAME.csv"
[[ -f $CSVNAME ]] || unzip -d "$NAME" "$FILENAME"
echo "Unpacked"


: Change owner of log file to your current user using chown
chown $USER $CSVNAME

: Change set executive bit to a random.sh script using chmod
chmod +x random.sh

: Execute the random.sh script
./random.sh

: Find the file using find
NEWLOC=$(find /usr -type f -name "$NAME.csv")

: Try to look for errors using your favorite editor
#vim "$NEWLOC"

: Try to find errors using grep
grep 404 "$NEWLOC" -m 10

: Tail last 500 lines of file
tail -n 500 "$NEWLOC"

: Find how many index.htm hits were at 30.06.2017 14:00
grep "2017-06-30,14:00" "$NEWLOC" | grep "index.htm" | wc -l

: Find how many index.htm hits were at 30.06.2017 17:00-18:00
grep "2017-06-30,17" "$NEWLOC" | grep "index.htm" | wc -l

: Show the number of times each IP shows up in the log – using sort and uniq utilities
cut -d, -f1 < "$NEWLOC" | sort | uniq -c | sort -rn

: Count all 13.94.212.jdf IP hits us
grep "13.94.212.jdf" "$NEWLOC" | wc -l

