FROM nimmis/apache-php5

MAINTAINER Christian Hain <christian@crhain.com>

# Install PHP 5.6 to work with latest Magento.
# Need to set the local to work with Ondrej's name, presumably.
RUN locale-gen en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
    && export LC_ALL=en_US.UTF-8 \
    && sudo add-apt-repository ppa:ondrej/php \
    && sudo apt-get -y update \
    && sudo apt-get -y install php5.6 php5.6-mcrypt php5.6-mbstring php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-intl php5.6-xsl php5.6-zip git-all \
    && sudo apt-get -y update

# add missing always_populate_raw_post_data = -1 to php.ini
# Not needed when moving to PHP 7.
# http://devdocs.magento.com/guides/v2.0/install-gde/trouble/php/tshoot_php-set.html#trouble-php-always
RUN echo "always_populate_raw_post_data=-1" >  /etc/php/5.6/cli/conf.d/always_populate_raw_post_data.ini

# EXPOSE 443

EXPOSE 80:80
CMD ["--port 80:80"]

COPY src/apache-config.conf /etc/apache2/sites-enabled/000-default.conf
COPY src/phpinfo.php /var/www/html/
COPY src/composer-auth.json /var/www/html/var/composer_home/auth.json

VOLUME $(pwd)/src/magento2:/var/www/html

# Add Magento User
# RUN useradd --create-home --password=null magento_user

# Set Permissions
CMD ["cd /var/www/html/magento2 \
    && find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; \
    && find var vendor pub/static pub/media app/etc -type d -exec chmod g+w {} \; \
    && chmod u+x bin/magento"]

# Switch User
# USER magento_user
# WORKDIR /var/www/html
