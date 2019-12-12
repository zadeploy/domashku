#!/bin/bash
echo "* * * * * ./exercise-memcached.sh" | crontab - -u vagrant
service cron restart
echo "exercise-memcached.sh cronjob started"