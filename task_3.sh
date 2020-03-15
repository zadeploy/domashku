#!/bin/bash

# Examine ls using strace command
strace ls ./

# Assess how Linux executes the ./random.sh script
touch log20170630.csv
strace ./random_picker.sh

# Count number of “mv” command paths using pipes and grep for strace ./random.sh
strace ./random_picker.sh 2>&1 | grep mv | wc -l
