# Projects

Simple docker container that includes php 8.0 and latest lts node

## Introduction

This is meant to be used for PHP and NODE development with docker and wsl on windows operating systems, and can be installed inside any distribution.

This project needs to be cloned inside your distribution, in user directory and set user and group as owner of the folder.

Doing so, you don't have to install anything on your distribution and redoing it at any point will be easy.

### Notes

- Clone it inside user home directory of your distribution of choice.
- Assign `folder` to user and user group (DO NOT USE root).
- Copy `.env.example` to `.env` and use `id -u <user>` `id -g <group>` to populate fields.
- Add or change variables inside `php.ini` and `supervisord.conf` if needed.
- build container using `docker-compose up -d`

### Additional info

- to go inside container from console: `docker exec -it <container-name> bash`
- ANY folders or files created inside container from commands like `composer create-project` or `npx create-react-app` will be added to `www-data:www-data` user and group inside
  container, but they will match ID and GROUP ID of the user and group that owns project folder.

_Happy Coding_
