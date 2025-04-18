# Docker PHP & Node Development Environment

A simple Docker-based container for PHP and Node.js projects that ensures files created inside the container match your host's UID/GID.

## Prerequisites

- Docker Engine & Docker Compose
- Git
- Linux or Windows WSL2

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ionghitun/projects.git
   cd projects
   ```
2. **Set ownership (avoid root!)**
   ```bash
   sudo chown -R $USER:$USER .
   ```
3. **Copy and configure environment variables**
   ```bash
   cp scripts/.env.example scripts/.env
   export PUID=$(id -u)
   export PGID=$(id -g)
   # Edit other variables in scripts/.env as needed
   ```

## Usage

```bash
./scripts/start.sh    # Start the container
./scripts/down.sh     # Stop the container
./scripts/build.sh    # Build or rebuild the container
./scripts/restart.sh  # Restart the container
./scripts/console.sh  # Open a shell into the container
```

## Customization

- **PHP Configuration**: Edit `scripts/php/php.ini`
- **Supervisor**: Edit `scripts/php/supervisord.conf`
- **Global Run**:
    1. Copy `scripts/run_all.sh.example` to `scripts/run_all.sh`
    2. Modify it to include paths to your other project directories
    3. Execute `./scripts/run_all.sh` to start multiple projects at once

> **Note:** Any files or folders created inside the container (e.g., via `composer create-project` or `npx create-react-app`) will have permissions matching your host UID/GID.

## Troubleshooting

- **Permission Issues**: Ensure `PUID` and `PGID` in `scripts/.env` match your host user IDs.
- **Docker Issues**: For older versions you might want to remove `COMPOSE_BAKE` from `.env`.
- **Docker Compose Issues**: Please update and ensure you can use `docker compose`, not old version `docker-compose`

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please open issues or submit pull requests following the repository guidelines.

_Happy Coding_
