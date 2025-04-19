#!/bin/sh
echo
echo "===== Restarting... ====="
echo

cd scripts || exit
docker compose restart

echo
echo "===== Done! ====="
echo
