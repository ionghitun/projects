#version
FROM php:8.2-fpm

#configure everything as root
USER root

#make owner www-data and match it to host and group ids so permissions match outside container
ARG USER_ID
ARG GROUP_ID

RUN userdel -f www-data
RUN if getent group www-data ; then groupdel www-data; fi
RUN groupadd -g ${GROUP_ID} www-data
RUN useradd -l -u ${USER_ID} -g www-data www-data
RUN chown -R www-data:www-data /var/www

RUN install -d -m 0755 -o www-data -g www-data /home/www-data
RUN chown -R www-data:www-data /home/www-data

RUN mkdir /var/log/supervisor
RUN chown -R www-data:www-data /var/log/supervisor
RUN touch /var/run/supervisord.pid
RUN chown -R www-data:www-data /var/run
RUN chown www-data:www-data /var/run/supervisord.pid

RUN apt-get update
RUN apt-get upgrade -y

#install some necesarry libraries
RUN apt-get install -y default-mysql-client nano git curl cron zip unzip zlib1g-dev libicu-dev g++ libxml2-dev supervisor libmcrypt-dev libzip-dev libmagickwand-dev imagemagick

RUN pecl update-channels

#default editor
RUN export EDITOR="/usr/bin/nano"

#composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#install and configure some extensions
RUN docker-php-ext-install intl && docker-php-ext-configure intl
RUN pecl install redis && docker-php-ext-enable redis
RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN pecl install imagick && docker-php-ext-enable imagick
RUN docker-php-ext-install gd && docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install zip exif pcntl bcmath soap pdo_mysql sockets gettext

#install latest stable node version
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs
RUN npm update -g

#supervisor sock
RUN python3 -c "import socket as s; sock = s.socket(s.AF_UNIX); sock.bind('/dev/shm/supervisor.sock')"

#set user back to www-data
USER www-data

#set supervisor to run to keep php-fpm up and running
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

#set working dir
WORKDIR /var/www
