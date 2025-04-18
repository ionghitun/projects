#!/bin/sh
cd scripts || exit

COMPOSE_PROJECT_NAME=$(grep -oP '^COMPOSE_PROJECT_NAME=\K.*' .env)

echo "Want to execute container as root? (y/n) [default: n]: "
read USE_ROOT

if [ "$USE_ROOT" = "y" ] || [ "$USE_ROOT" = "Y" ]; then
    docker exec -u root -it "${COMPOSE_PROJECT_NAME}" bash
else
    docker exec -it "${COMPOSE_PROJECT_NAME}" bash
fi
