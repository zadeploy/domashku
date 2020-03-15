#!/bin/bash


#1 Examine ls using strace command
apt-get install strace
strace ls ./

#2 Assess how Linux executes the ./random_picker.sh script
touch ./log20170630/log20170630.csv
strace ./random_picker.sh

#3 Count number of 'mv' commands paths using pipes and grep for strace ./random_picker.sh
strace ./random_picker.sh 2>&1 | grep mv | wc -l

