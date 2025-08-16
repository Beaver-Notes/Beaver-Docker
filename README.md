# Beaver Notes - Dockerized

<div style="text-center"><a href="https://github.com/Beaver-Notes/Beaver-Notes">Beaver Notes</a> is the a privacy-focused note-taking application.<div>

This repository provides a **Dockerized version** of Beaver Notes, built on top of [LinuxServer.io’s baseimage-kasmvnc (Debian Bookworm)](https://github.com/linuxserver/docker-baseimage-kasmvnc).

## ✨ Features

- Runs Beaver Notes in a containerized environment
- Preinstalled dependencies for GTK, DBus, and system integration
- Exposes Beaver Notes via **KasmVNC** (web browser access)
- Configurable persistent storage via Docker volumes

## 🚀 Getting Started

### Run with Docker

```bash
docker run -d \
  --name=beaver-notes \
  -e PUID=1000 \
  -e PGID=1000 \
  -p 3000:3000 \
  -v /path/to/config:/config \
  ghcr.io/beaver-notes/beaver-notes:latest
```

### Run with Docker

```yml
version: "3.8"

services:
  beaver-notes:
    image: ghcr.io/beaver-notes/beaver-notes:latest
    container_name: beaver-notes
    environment:
      - PUID=1000
      - PGID=1000
    ports:
      - 3000:3000
    volumes:
      - /path/to/config:/config
    restart: unless-stopped
```

Currently supported:

- `amd64`
- `arm64`

### Access

- Open your browser and go to:
  `http://localhost:3000`

## ⚙️ Environment Variables

| Variable               | Description                                       | Default   |
| ---------------------- | ------------------------------------------------- | --------- |
| `PUID`                 | User ID the container runs as                     | `1000`    |
| `PGID`                 | Group ID the container runs as                    | `1000`    |
| `BEAVER_NOTES_VERSION` | Beaver Notes version (build arg)                  | `4.0.0`   |
| `DOCKER_IMAGE_VERSION` | Image version label (build arg, set during build) | `unknown` |

## 📂 Volumes

| Path      | Description                                    |
| --------- | ---------------------------------------------- |
| `/config` | Stores Beaver Notes config and persistent data |

## 📡 Ports

| Port | Description            |
| ---- | ---------------------- |
| 3000 | Web access via KasmVNC |

## 📜 License

This Docker image is distributed under the same license as [Beaver Notes](https://github.com/Beaver-Notes/Beaver-Notes).

## 🙌 Credits

- [LinuxServer.io Baseimage KasmVNC](https://github.com/linuxserver/docker-baseimage-kasmvnc)
