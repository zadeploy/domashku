#! /bin/bash

touch log20170630/log20170630.csv
strace ./random.sh

touch log20170630/log20170630.csv
strace ./random.sh 2>&1 | grep mv -c
