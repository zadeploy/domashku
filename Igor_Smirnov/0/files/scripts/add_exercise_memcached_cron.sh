#!/bin/bash
echo "* * * * * ./exercise-memcached.sh" | crontab - -u vagrant
echo "exercise-memcached.sh cronjob started"