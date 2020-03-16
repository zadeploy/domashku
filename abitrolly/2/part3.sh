#!/bin/bash

set -x
set -o errexit
set -o nounset

: Examine ls using strace command
strace ls ./

: Assess how Linux executes the ./random.sh script
touch log20170630/log20170630.csv
strace ./random.sh

: Count number of “mv” command paths using pipes and grep for strace ./random.sh
touch log20170630/log20170630.csv
strace ./random.sh 2>&1 | grep mv -c

