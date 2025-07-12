#!/bin/sh

echo
printf "Do you want to get and configure entire docker stack [nginx-proxy, minio, mailpit, docker-mysql, docker-mongo, docker-redis, portainer]? (y/n) [default: y]: "
read CONFIGURE_STACK
CONFIGURE_STACK=${CONFIGURE_STACK:-y}

if [ "$CONFIGURE_STACK" = "y" ] || [ "$CONFIGURE_STACK" = "Y" ]; then
    echo
    echo "===== Configuring, please wait... ====="
    echo

    cp scripts/.env.example scripts/.env
    sh scripts/start.sh

    git clone https://github.com/ionghitun/nginx-proxy.git
    cp nginx-proxy/scripts/.env.example nginx-proxy/scripts/.env
    cd nginx-proxy
    docker network create nginx-proxy
    sh scripts/start.sh

    cd ../
    git clone https://github.com/ionghitun/minio.git
    cp minio/scripts/.env.example minio/scripts/.env
    cd minio
    sh scripts/start.sh

    cd ../
    git clone https://github.com/ionghitun/mailpit.git
    cp mailpit/scripts/.env.example mailpit/scripts/.env
    cd mailpit
    sh scripts/start.sh

    cd ../
    git clone https://github.com/ionghitun/docker-mysql.git
    cp docker-mysql/scripts/.env.example docker-mysql/scripts/.env
    cd docker-mysql
    sh scripts/start.sh

    cd ../
    git clone https://github.com/ionghitun/docker-mongo.git
    cp docker-mongo/scripts/.env.example docker-mongo/scripts/.env
    cd docker-mongo
    sh scripts/start.sh

    cd ../
    git clone https://github.com/ionghitun/docker-redis.git
    cp docker-redis/scripts/.env.example docker-redis/scripts/.env
    cd docker-redis
    sh scripts/start.sh

    cd ../
    git clone https://github.com/ionghitun/portainer.git
    cp portainer/scripts/.env.example portainer/scripts/.env
    cd portainer
    sh scripts/start.sh

    cd ..
    cp scripts/run_all.sh.example scripts/run_all.sh

    echo
    echo "===== Done! ====="
    echo
    echo "Add these lines to your hosts file:"
    echo
    echo "127.0.0.1 minio.dev.local"
    echo "127.0.0.1 mail.dev.local"
    echo "127.0.0.1 portainer.dev.local"
    echo
    echo "To start/restart all at once run: sh scripts/run_all.sh"
    echo
    echo "To create a new mysql database in docker-mysql folder run: sh scripts/create-db.sh"
    echo
    echo "Please check specific README for additional info and .env files for for credentials"
    echo

fi

echo
echo "===== Cancelled! ====="
echo
