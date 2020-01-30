apt-get install cron -y
echo "* * * * * ./exercise-memcached.sh" | crontab - -u vagrant
service cron restart
echo "exercise-memcached.sh cronjob start"
