#!/bin/bash
set -e; rm -f /var/run/apache2/apache2.pid; /usr/sbin/apache2ctl -D FOREGROUND

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

# Set domain addresses
cd /var/www/magento2;
./bin/magento setup:store-config:set --base-url="http://advancedspecialty.com";
./bin/magento setup:store-config:set --base-url-secure="https://advancedspecialty.com";

# Start Cron
/etc/init.d/cron start
./bin/magento setup:cron:run
