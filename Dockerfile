FROM php:5-apache

RUN apt-get update && apt-get -y install git

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h 
RUN apt-get update && apt-get install -y \
    libmcrypt-dev libgmp-dev \
    libz-dev \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-configure gmp --with-gmp=/usr/include/x86_64-linux-gnu \
    && docker-php-ext-install zip \
    && docker-php-ext-install gmp

RUN git clone -b v1.13.2 https://github.com/simplesamlphp/simplesamlphp /usr/share/simplesamlphp

RUN cd /usr/share/simplesamlphp && curl -sS https://getcomposer.org/installer | php
RUN cd /usr/share/simplesamlphp && php composer.phar install

RUN ln -s /usr/share/simplesamlphp/www /var/www/html/idp
RUN touch /var/www/html/index.html
