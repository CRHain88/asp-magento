#!/bin/bash
set -e; rm -f /var/run/apache2/apache2.pid; /usr/sbin/apache2ctl -D FOREGROUND &&

# Start Cron
/etc/init.d/cron start

# Set Varialbes
if [ "$1" = "local" ]
then
    DOMAIN="localhost"
elif [ "$1" = "stage" ]
then
    DOMAIN="advancedspecialty.crhain.com"
elif [ "$1" = "production" ]
then
    DOMAIN="advancedspecialty.com"
fi
cd /var/www/magento2;
./bin/magento setup:store-config:set --base-url="http://$DOMAIN";
./bin/magento setup:store-config:set --base-url-secure="https://$DOMAIN";
