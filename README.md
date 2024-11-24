# Projects

Simple container with php and node where you can create new projects with same user and group as host

## Introduction

This is meant to be used for PHP and NODE projects development with docker on linux or windows wsl, and can be
installed inside any distribution.

### Install Notes

- clone it
- assign `projects` (cloned directory) to user and user group (DO NOT USE root).
- copy `.env.example` to `.env` and use `id -u <user>` and `id -g <user>` to populate some of the fields.
- change other env variables to your needs
- add or change variables inside `php.ini` and `supervisord.conf` if needed.
- build container using `docker-compose up -d`

### Additional info

- to go inside container from console: `docker exec -it CONTAINER_NAME bash`
- ANY folders or files created inside container from commands like `composer create-project` or `npx create-react-app`
  will be added to `www-data:www-data` user and group inside
  container, but they will match USER ID and GROUP ID of the user and group that owns project folder.

_Happy Coding_
