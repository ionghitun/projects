#!/bin/sh
echo
echo "===== Restarting... ====="
echo

cd scripts || exit

COMPOSE_PROJECT_NAME=$(grep -oP '^COMPOSE_PROJECT_NAME=\K.*' .env)

docker compose restart

echo
echo "===== Done! ====="
echo
