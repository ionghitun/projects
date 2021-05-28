FROM php:8.0-fpm

RUN mkdir /var/log/supervisor
RUN touch /var/run/supervisord.pid

RUN apt-get update && apt-get install -y acl vim git zip unzip zlib1g-dev libicu-dev g++ libxml2-dev supervisor

RUN export EDITOR="/usr/bin/vim"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install intl exif pcntl bcmath soap
RUN pecl install redis

RUN docker-php-ext-configure intl

RUN docker-php-ext-enable redis

ADD ./default-php/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

RUN python -c "import socket as s; sock = s.socket(s.AF_UNIX); sock.bind('/dev/shm/supervisor.sock')"

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

WORKDIR /var/www
