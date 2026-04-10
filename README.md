# SimpleHelp Server Docker

[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Eclipse Temurin](https://img.shields.io/badge/Eclipse%20Temurin-17--JRE-orange?logo=eclipseadoptium&logoColor=white)](https://adoptium.net/)
[![Alpine Linux](https://img.shields.io/badge/Alpine%20Linux-0D597F?logo=alpinelinux&logoColor=white)](https://alpinelinux.org/)
[![GitHub](https://img.shields.io/badge/GitHub-Alzarak%2FSimplehelp--Server--Docker-blue?logo=github)](https://github.com/Alzarak/Simplehelp-Server-Docker)
[![Built with Claude Code](https://img.shields.io/badge/Built%20with-Claude%20Code-DA7857?logo=anthropic)](https://claude.ai/code)

## Overview

A Docker image for running [SimpleHelp](https://simple-help.com/) remote support server in a container. Uses a multi-stage build with Alpine for downloading and Eclipse Temurin 17 JRE for runtime, resulting in a smaller final image. The container runs as a non-root user (`simplehelpuser`) via `gosu` for improved security.

## Features

- Multi-stage build -- Alpine downloads, Temurin 17 JRE runs
- Non-root execution via `gosu` and dedicated `simplehelpuser`
- Persistent configuration via volume mount
- Automatic download of latest SimpleHelp Linux AMD64 release

## Getting Started

### Docker Compose (recommended)

```bash
git clone https://github.com/Alzarak/Simplehelp-Server-Docker.git
cd Simplehelp-Server-Docker
docker compose up -d
```

This exposes ports `80` and `443` and persists configuration to `./opt/SimpleHelp/configuration`.

### Manual Build and Run

```bash
docker build -t alzahar/simplehelpserver:latest .

docker run -d \
  --name simplehelp \
  -p 80:80 \
  -p 443:443 \
  -v ./opt/SimpleHelp/configuration:/opt/SimpleHelp/configuration \
  alzahar/simplehelpserver:latest
```

### Access

Open your browser to `http://localhost` (or `https://localhost` once SSL is configured).

## Repository Structure

```
Simplehelp-Server-Docker/
├── Dockerfile           # Multi-stage build (Alpine + Temurin 17 JRE)
├── entrypoint.sh        # Sets ownership and starts server as simplehelpuser
├── compose.yaml         # Docker Compose service definition
├── opt/SimpleHelp/
│   └── configuration/   # Persisted server configuration (volume mount)
└── README.md
```

## Configuration

The `compose.yaml` mounts `./opt/SimpleHelp/configuration` into the container. SimpleHelp stores its server configuration, SSL certificates, and backups here. This data persists across container restarts and rebuilds.

**Exposed Ports:**

| Port | Purpose |
|------|---------|
| 80   | HTTP    |
| 443  | HTTPS   |

## Reporting Issues

[GitHub Issues](https://github.com/Alzarak/Simplehelp-Server-Docker/issues)

## License

SimpleHelp is commercial software. Refer to the [SimpleHelp license](https://simple-help.com/) for usage terms. This Docker packaging is provided as-is.

## Author

- **Docker Image:** [Alzarak](https://github.com/Alzarak)
- **Original Software:** [SimpleHelp](https://simple-help.com/)
