# php-node

Simple docker container that includes Php 8.0 and latest Node version

### Notes

- Assign `projects` folder to a user and group (DO NOT use root).
- copy `.env.example` to `.env` and use `id -u <user>` `id -g <group>` to populate fields.
- Inside container, you have php with composer and node with npm/npx.
- ANY folders or files created from inside container from commands (`composer create-project`, `npx create-react-app`) or manual will be owned by `www-data:www-data` inside container, but they will match ID and GROUP ID of the user and group that owns project folder.

_Happy Coding_
