#version
ARG PHP_BASE_IMAGE=php:8.4-fpm
FROM ${PHP_BASE_IMAGE}

#configure everything as root
USER root

#make owner www-data and match it to host and group ids so permissions match outside container
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN userdel -f www-data
RUN if getent group www-data ; then groupdel www-data; fi
RUN groupadd -g ${GROUP_ID} www-data
RUN useradd -l -u ${USER_ID} -g www-data www-data
RUN chown -R www-data:www-data /var/www
RUN install -d -m 0755 -o www-data -g www-data /home/www-data
RUN chown -R www-data:www-data /home/www-data

#supervisor data
RUN mkdir /var/log/supervisor
RUN chown -R www-data:www-data /var/log/supervisor
RUN touch /var/run/supervisord.pid
RUN chown -R www-data:www-data /var/run
RUN chown www-data:www-data /var/run/supervisord.pid

#update distribution
RUN apt-get update
RUN apt-get upgrade -y

#install some necesarry libraries
RUN apt-get install -y supervisor git zip unzip nano
RUN pecl update-channels

#default editor
RUN export EDITOR="/usr/bin/nano"

#composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#install node
ARG NODE_VERSION=22
RUN curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh
RUN chmod 500 nsolid_setup_deb.sh
RUN ./nsolid_setup_deb.sh ${NODE_VERSION}
RUN apt-get install -y nodejs
RUN npm update -g

#supervisor sock
RUN python3 -c "import socket as s; sock = s.socket(s.AF_UNIX); sock.bind('/dev/shm/supervisor.sock')"

#set user back to www-data
USER www-data

#laravel installer
RUN composer global require laravel/installer
RUN echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.bashrc

#set supervisor to run to keep php-fpm up and running
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

#set working dir
WORKDIR /var/www
