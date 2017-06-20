FROM asp_server
MAINTAINER Christian Hain <christian@crhain.com>

COPY src/apache-config.conf /etc/apache2/sites-enabled/000-default.conf
COPY src/entry-point.sh /usr/local/bin/entry-point.sh
COPY src/crontab /var/spool/cron/crontabs/root

COPY src/phpinfo.php /var/www/magento2/
COPY src/composer-auth.json /var/www/magento2/var/composer_home/auth.json
COPY src/magento2 /var/www/magento2/

VOLUME src/magento2/var/backups:/var/www/magento2/var/backups
VOLUME src/magento2/var/cache:/var/www/magento2/var/cache
VOLUME src/magento2/var/composer_home:/var/www/magento2/var/compose_home
VOLUME src/magento2/var/generation:/var/www/magento2/var/generation
VOLUME src/magento2/var/log:/var/www/magento2/var/log
VOLUME src/magento2/var/page_cache:/var/www/magento2/var/page_cache
VOLUME src/magento2/var/report:/var/www/magento2/var/report
VOLUME src/magento2/var/tmp:/var/www/magento2/var/tmp
VOLUME src/magento2/var/vew_preprocessed:/var/www/magento2/var/vew_preprocessed

# Add Magento User
# RUN useradd --create-home --password=null magento_user

# Set Permissions
CMD ["cd /var/www/magento2 \
    && find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; \
    && find var vendor pub/static pub/media app/etc -type d -exec chmod g+w {} \; \
    && chmod u+x bin/magento"]

# Switch User
# USER magento_user
WORKDIR /var/www/magento2

ENTRYPOINT ["/usr/local/bin/entry-point.sh", "local"]
