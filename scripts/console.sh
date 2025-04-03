#!/bin/sh
cd scripts || exit
STACK_NAME=$(grep -oP '^STACK_NAME=\K.*' .env)

# Read user input
echo "Want to execute container as root? (y/n) [default: n]: "
read USE_ROOT

# Check user input in a POSIX-compatible way
if [ "$USE_ROOT" = "y" ] || [ "$USE_ROOT" = "Y" ]; then
    docker exec -u root -it "${STACK_NAME}" bash
else
    docker exec -it "${STACK_NAME}" bash
fi
