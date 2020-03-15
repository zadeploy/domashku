#!/bin/bash

strace ls ./

touch ./log20170630/log20170630.csv

strace ./random_picker.sh

strace ./random_picker.sh 2>&1 | grep mv | wc -l

