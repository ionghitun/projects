ARG PHP_IMAGE_VERSION=php:8.4-fpm
FROM ${PHP_IMAGE_VERSION}

USER root

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG APP_USER=appuser
ARG NODE_VERSION=22

RUN set -eux; \
    EXISTING_USER=$(getent passwd "$USER_ID" | cut -d: -f1 || true); \
    EXISTING_GROUP=$(getent group "$GROUP_ID" | cut -d: -f1 || true); \
    if [ -n "$EXISTING_USER" ]; then \
        echo "User with UID $USER_ID already exists: $EXISTING_USER. Renaming to $APP_USER."; \
        usermod -l "$APP_USER" "$EXISTING_USER" || true; \
    else \
        if [ -z "$EXISTING_GROUP" ]; then \
            groupadd -g "$GROUP_ID" "$APP_USER"; \
        fi; \
        useradd -m -u "$USER_ID" -g "$GROUP_ID" -s /bin/bash "$APP_USER"; \
    fi; \
    mkdir -p /home/"$APP_USER" /var/log/supervisor /var/run /app; \
    chown -R "$APP_USER:$GROUP_ID" /home/"$APP_USER" /var/log/supervisor /var/run /app; \
    touch /var/run/supervisord.pid /var/run/crond.pid; \
    chown "$APP_USER:$GROUP_ID" /var/run/supervisord.pid /var/run/crond.pidgi

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        supervisor git zip unzip nano curl ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && pecl update-channels

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs \
    && npm update -g

USER ${APP_USER}

ENV COMPOSER_HOME="/home/${APP_USER}/.composer"
ENV PATH="$COMPOSER_HOME/vendor/bin:$PATH"

RUN composer global require laravel/installer

WORKDIR /app

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
