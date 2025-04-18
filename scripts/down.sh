#!/bin/sh
echo
echo "===== Stopping... ====="
echo

cd scripts || exit

COMPOSE_PROJECT_NAME=$(grep -oP '^COMPOSE_PROJECT_NAME=\K.*' .env)

docker compose down

echo
echo "===== Done! ====="
echo
