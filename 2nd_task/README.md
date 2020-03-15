# Part 1
1. wget http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip
2. unzip log20170630.zip
3. chown andrey:users log20170630.csv
4. chmod +x random_picker.sh
5. sudo ./random_picker.sh
6. sudo find /usr -type f -name "log20170630.csv"
7. vim log
/error
8. cat log20170630.csv| grep error (grep error log20170630.csv)
9. tail -n500 log20170630.csv
10. cat log20170630.csv| awk -F "," '$2 == "2017-06-30" && $3 == "14:00:00"' | grep index.htm -c
11. cat log20170630.csv| awk -F "," '$2 == "2017-06-30" && $3 >= "17:00:00" && $3 <= "18:00:00"' | grep index.htm -c
12. cat log20170630.csv | awk -F "," '{print $1}' | sort | uniq -c | sort -nr
13. cat log20170630.csv | grep 13.94.212.jdf -c

# Part 2 
Script 2ndtask.sh

# Part 3 
strace -e trace=stat ./random_picker.sh 2>&1 | grep mv | uniq | wc -l
