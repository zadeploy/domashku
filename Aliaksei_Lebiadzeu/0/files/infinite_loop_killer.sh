#!/bin/bash

ps aux | grep infinite-loop 
echo "Killing running infinite-loop"
killall -r infinite-loop 2>/dev/null # kill current infinite-loop processes
echo "Removing infinite-loop"
update-rc.d -f infinite-loop remove 1>&2 >/dev/null # unregister infinite-loop from autostart
rm -f /etc/init.d/infinite-loop # remove file with infinite-loop script
