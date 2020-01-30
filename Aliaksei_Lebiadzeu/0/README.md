# Issues in the health of the system

##### Problem:
  CPU load more then 98%. Almost all CPU used by process:
  ` root      1033 95.3  0.1  17972   688 ?        R    15:48   3:35 /bin/bash /etc/rc2.d/S20infinite-loop start`
  Look at `/etc/rc2.d/S20infinite-loop`, this is symlink file to `/etc/init.d/infinite-loop`. This file is bash script with infinite loop that make "Some math to stress the CPU" .
  As Google say such scripts starts when system load.
##### Resolution(maybe not very good) added to `files/provision.sh`
  Kill current process by name:
 `sudo killall -r infinite-loop`
  Unregister service infinite-loop:
  `sudo update-rc.d -f infinite-loop remove`
  Remove file with infinite-loop from init.d directory:
  `sudo rm /etc/init.d/infinite-loop`
