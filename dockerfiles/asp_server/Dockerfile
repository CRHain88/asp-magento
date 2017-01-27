FROM ubuntu:latest
MAINTAINER Christian Hain <christian@crhain.com>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

# Install PHP 5.6 to work with latest Magento.
# Need to set the local to work with Ondrej's name, presumably.
RUN locale-gen en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
    && export LC_ALL=en_US.UTF-8

# Install Apache
RUN apt-get update \
    && apt-get install -y apache2

# Install PHP5.6
RUN apt-get update \
    && apt-get -y install software-properties-common python-software-properties \
    && apt-get update

RUN locale-gen en_US.UTF-8 \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get -y install php5.6 \
    && apt-get -y install php5.6-curl php5.6-gd php5.6-intl php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-soap php5.6-xml php5.6-xsl php5.6-zip \
    && apt-get -y install php5.6-readline php5.6-cli git-all \
    && apt-get update

# RUN add-apt-repository -y ppa:ondrej/php \
#     && apt-get update \
#     && apt-get -y install php7-json php7-iconv

# add missing always_populate_raw_post_data = -1 to php.ini
# Not needed when moving to PHP 7.
# http://devdocs.magento.com/guides/v2.0/install-gde/trouble/php/tshoot_php-set.html#trouble-php-always
RUN echo "always_populate_raw_post_data=-1" > /etc/php/5.6/cli/conf.d/always_populate_raw_post_data.ini

RUN a2enmod rewrite

#apt-cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
