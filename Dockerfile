FROM asp_server
MAINTAINER Christian Hain <christian@crhain.com>

COPY src/apache-config.conf /etc/apache2/sites-enabled/000-default.conf
COPY src/phpinfo.php /var/www/html/
COPY src/composer-auth.json /var/www/html/var/composer_home/auth.json
COPY src/magento2 /var/www/html/

VOLUME src/magento2/var/backups:/var/www/html/var/backups
VOLUME src/magento2/var/cache:/var/www/html/var/cache
VOLUME src/magento2/var/composer_home:/var/www/html/var/compose_home
VOLUME src/magento2/var/generation:/var/www/html/var/generation
VOLUME src/magento2/var/log:/var/www/html/var/log
VOLUME src/magento2/var/page_cache:/var/www/html/var/page_cache
VOLUME src/magento2/var/report:/var/www/html/var/report
VOLUME src/magento2/var/tmp:/var/www/html/var/tmp
VOLUME src/magento2/var/vew_preprocessed:/var/www/html/var/vew_preprocessed

# Add Magento User
# RUN useradd --create-home --password=null magento_user

# Set Permissions
CMD ["cd /var/www/html \
    && find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; \
    && find var vendor pub/static pub/media app/etc -type d -exec chmod g+w {} \; \
    && chmod u+x bin/magento"]

# Switch User
# USER magento_user
WORKDIR /var/www/html
