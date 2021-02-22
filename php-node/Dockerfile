FROM php:8.0-fpm

WORKDIR /var/www

RUN apt-get update && apt-get install -y acl vim git zip unzip zlib1g-dev libicu-dev g++ libxml2-dev

RUN export EDITOR="/usr/bin/vim"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install intl exif pcntl bcmath soap
RUN pecl install redis

RUN docker-php-ext-configure intl

RUN docker-php-ext-enable redis

# Install node
RUN curl -sL https://deb.nodesource.com/setup_current.x | bash -
RUN apt-get install -y nodejs

RUN chown -R www-data:www-data /var/www
RUN setfacl -dRm u:www-data:rwx /var/www
