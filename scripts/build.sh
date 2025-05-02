#!/bin/sh
cd scripts || exit

echo
printf "Do you want to update image before rebuilding? (y/n) [default: y]: "
read UPDATE_IMAGES
UPDATE_IMAGES=${UPDATE_IMAGES:-y}

if [ "$UPDATE_IMAGES" = "y" ] || [ "$UPDATE_IMAGES" = "Y" ]; then
    echo
    echo "===== Updating image... ====="
    echo

    PHP_IMAGE_VERSION=$(sed -n 's/^PHP_IMAGE_VERSION=//p' .env)
    docker pull "$PHP_IMAGE_VERSION"
fi

echo
echo "===== Building and starting container... ====="
echo

if command -v docker-compose >/dev/null 2>&1; then
    docker-compose build --no-cache
    docker-compose up -d
else
    docker compose build --no-cache
    docker compose up -d
fi

echo
echo "===== Done! ====="
echo
