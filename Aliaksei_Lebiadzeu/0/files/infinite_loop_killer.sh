#!/bin/bash

ps aux | grep infinite-loop 
sudo killall -r infinite-loop 2>/dev/null # kill current infinite-loop processes
sudo update-rc.d -f infinite-loop remove 1>&2 >/dev/null # unregister infinite-loop from autostart
sudo rm -f /etc/init.d/infinite-loop # remove file with infinite-loop script
