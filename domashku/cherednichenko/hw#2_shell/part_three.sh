#!/bin/bash

#Examine ls using strace command 
#apt-get install strace 
#strace ls ./ 
#Assess how Linux executes the ./random.sh script    
#touch log20170630.csv 
#strace ./random.sh 
#Count number of “mv” command paths using pipes and grep for strace ./random.sh 

touch log20170630/log20170630.csv |sudo  strace  ./random_picker.sh 2>&1 | grep -c "/bin/mv"
sudo find  /usr -type f -name "log20170630.csv"
