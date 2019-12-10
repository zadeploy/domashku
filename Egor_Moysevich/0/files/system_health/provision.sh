#!/bin/bash

# No more CPU stress!
sudo update-rc.d infinite-loop disable > /dev/null
sudo killall -q -r infinite-loop > /dev/null
echo 'system health is ok'
