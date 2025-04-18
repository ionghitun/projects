#!/bin/sh
echo
echo "===== Starting... ====="
echo

cd scripts || exit

COMPOSE_PROJECT_NAME=$(grep -oP '^COMPOSE_PROJECT_NAME=\K.*' .env)

docker compose up -d

echo
echo "===== Done! ====="
echo
