#!/bin/sh
echo "*** Rebuild start ***"

cd scripts || exit

# Prompt user for input
echo "Want to update images before rebuild? (y/n) [default: y]: "
read UPDATE_IMAGES
UPDATE_IMAGES=${UPDATE_IMAGES:-y}

# Check user input in a POSIX-compatible way
if [ "$UPDATE_IMAGES" = "y" ] || [ "$UPDATE_IMAGES" = "Y" ]; then
    PHP_IMAGE_VERSION=$(grep -oP '^PHP_IMAGE_VERSION=\K.*' .env)

    docker pull "$PHP_IMAGE_VERSION"
fi

STACK_NAME=$(grep -oP '^STACK_NAME=\K.*' .env)

echo "*** Rebuilding application ***"
docker compose -p "$STACK_NAME" build --no-cache
docker compose -p "$STACK_NAME" up -d

echo "*** Rebuild ended ***"
