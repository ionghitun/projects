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

    PHP_IMAGE_VERSION=$(grep -oP '^PHP_IMAGE_VERSION=\K.*' .env)
    docker pull "$PHP_IMAGE_VERSION"
fi

echo
echo "===== Building and starting container... ====="
echo

docker compose build --no-cache
docker compose up -d

echo
echo "===== Done! ====="
echo
