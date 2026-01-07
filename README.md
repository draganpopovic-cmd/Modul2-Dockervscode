
<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [README.md](#readmemd)
  - [Voraussetzungen](#voraussetzungen)
  - [Quickstart](#quickstart)
  - [Enthaltene Tools](#enthaltene-tools)
  - [Ports und Volumes](#ports-und-volumes)
  - [Sicherheitshinweis](#sicherheitshinweis)
- [Devcontainer Microsoft](#devcontainer-microsoft)

<!-- /code_chunk_output -->




# README.md
Dieses Repository stellt einen einfachen Devcontainer bereit, der gängige
Entwickler-Tools (Docker, Node.js, Python) sowie Security-Tools (Trivy,
Gitleaks) in einem Ubuntu-Container bündelt.

## Voraussetzungen
- Docker Desktop oder Docker Engine
- Docker Compose (v2 empfohlen)
- Optional: VS Code + Dev Containers Extension

## Quickstart
Build und Start:

```bash
docker compose up --build
```


Container stoppen:

```bash
docker compose down
```

## Enthaltene Tools
Aus dem `Dockerfile` werden u. a. installiert:
- git, curl, wget, vim, build-essential
- python3, pip
- nodejs (LTS) + newman
- trivy
- gitleaks
- docker.io (für Docker-in-Docker via Socket)

## Ports und Volumes
In `docker-compose.yml`:
- Ports: `3000`, `8000` (Beispiele, anpassbar)
- Volume: `.:/workspace` bindet den Projektordner ins Container-`/workspace`
- Docker-Socket: `/var/run/docker.sock` für Docker-Befehle im Container

## Sicherheitshinweis
Der Mount des Docker-Sockets erlaubt dem Container Zugriff auf den Host-Docker
und damit weitreichende Rechte. Verwende dies nur in vertrauenswürdigen
Umgebungen.


# Devcontainer Microsoft
https://hub.docker.com/r/microsoft/vscode-devcontainers




