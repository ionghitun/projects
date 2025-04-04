# Projects

Simple container with php and node where you can create new projects with same user and group as host

## Introduction

This is meant to be used for PHP and NODE projects development with docker on linux or windows wsl, and can be
installed inside any distribution.

### Install Notes

- clone it
- assign `projects` (cloned directory) to user and user group (DO NOT USE root).
- copy `scripts/.env.example` to `scripts/.env` and use `id -u <user>` and `id -g <user>` to populate some of the fields.
- change other env variables to your needs
- add or change variables inside `scripts/php/php.ini` and `scripts/php/supervisord.conf` if needed.
- run `sh scripts/start.sh` to start the project
- run `sh scripts/stop.sh` to stop the project
- run `sh scripts/build.sh` to build or rebuild the project
- run `sh scripts/restart.sh` to restarts container
- run `sh scripts/console.sh` to exec the container

### Additional info

- copy `scripts/run_all.sh.example` to `scripts/run_all.sh` and modify it to your needs, then by running `sh scripts/run_all.sh` you can start all your other projects in one
  command
- added laravel installer
- ANY folders or files created inside container from commands like `laravel new laravel`, `composer create-project` or `npx create-react-app`
  will be added to `www-data:www-data` user and group inside
  container, but they will match USER ID and GROUP ID of the user and group that owns project folder.

_Happy Coding_
