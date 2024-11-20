# Docker Workshop - Theoretische Grundlagen

# 1. Docker Grundkonzepte
## 1.1 Was ist Docker?
- Container vs. VMs
- Docker Engine
- Docker Client
- Docker Registry
- Docker Hub

### Installation prüfen
```bash
# Version anzeigen
docker --version

# System-Info
docker info

# Hello World Test
docker run hello-world
```

## 1.2 Container Lebenszyklus
### Container Status
- Created
- Running
- Paused
- Stopped
- Deleted

```bash
# Container starten
docker run -d nginx

# Status prüfen
docker ps
docker ps -a  # alle Container

# Container stoppen
docker stop <container-id>

# Container löschen
docker rm <container-id>
```

## 1.3 Images
### Image Management
```bash
# Images auflisten
docker images

# Image pullen
docker pull nginx:latest

# Image löschen
docker rmi nginx:latest

# Ungenutzte Images bereinigen
docker image prune
```

# 2. Container Operations
## 2.1 Container Ausführen
### Basis-Befehle
```bash
# Interaktiver Modus
docker run -it ubuntu bash

# Detached Modus
docker run -d nginx

# Mit Port-Mapping
docker run -d -p 8080:80 nginx

# Mit Namen
docker run -d --name my-nginx nginx
```

### Container Management
```bash
# Container stoppen
docker stop my-nginx

# Container starten
docker start my-nginx

# In Container einloggen
docker exec -it my-nginx bash

# Container Logs
docker logs -f my-nginx
```

## 2.2 Container Konfiguration
### Umgebungsvariablen
```bash
# Einzelne Variable
docker run -e MYSQL_ROOT_PASSWORD=secret mysql

# Aus Datei
docker run --env-file .env mysql
```

### Ressourcen-Limits
```bash
# Memory Limit
docker run -m 512m nginx

# CPU Limit
docker run --cpus=".5" nginx

# Beide
docker run -m 512m --cpus=".5" nginx
```

# 3. Datenpersistenz
## 3.1 Docker Volumes
### Named Volumes
```bash
# Volume erstellen
docker volume create mysql-data

# Volume verwenden
docker run -d \
  -v mysql-data:/var/lib/mysql \
  mysql

# Volumes auflisten
docker volume ls

# Volume inspizieren
docker volume inspect mysql-data
```

### Bind Mounts
```bash
# Lokales Verzeichnis mounten
docker run -d \
  -v $(pwd):/usr/share/nginx/html \
  nginx

# Readonly Mount
docker run -d \
  -v $(pwd):/usr/share/nginx/html:ro \
  nginx
```

# 4. Netzwerke
## 4.1 Network Basics
### Netzwerk-Typen
- bridge
- host
- none
- overlay (Swarm)

```bash
# Netzwerke auflisten
docker network ls

# Netzwerk erstellen
docker network create my-net

# Container verbinden
docker run -d --network my-net nginx
```

## 4.2 Container Kommunikation
```bash
# Container im gleichen Netzwerk
docker run -d --name db --network my-net mysql
docker run -d --name web --network my-net nginx

# DNS-Auflösung testen
docker exec web ping db
```

# 5. Images Bauen
## 5.1 Dockerfile Basics
### Grundlegende Befehle
```dockerfile
# Beispiel Dockerfile
FROM php:8.1-fpm

# Pakete installieren
RUN apt-get update && apt-get install -y \
    libzip-dev \
    && docker-php-ext-install zip

# Arbeitsverzeichnis
WORKDIR /var/www/html

# Dateien kopieren
COPY . .

# Standard-Befehl
CMD ["php-fpm"]
```

### Image Build
```bash
# Image bauen
docker build -t my-php-app .

# Mit Build Args
docker build --build-arg VERSION=8.1 -t my-php-app .

# Multi-Stage Build
docker build --target prod -t my-php-app .
```

## 5.2 Best Practices
### Optimierung
```dockerfile
# Mehrstufiger Build
FROM composer as builder
COPY . .
RUN composer install --no-dev

FROM php:8.1-fpm
COPY --from=builder /app /var/www/html
```

### .dockerignore
```
node_modules
vendor
.git
*.log
```

# 6. Docker Compose
## 6.1 Compose Basics
### Compose File
```yaml
# docker-compose.yml
version: '3.8'

services:
  web:
    image: nginx
    ports:
      - "8080:80"
    volumes:
      - ./src:/var/www/html
    depends_on:
      - php
      
  php:
    build: .
    volumes:
      - ./src:/var/www/html
    depends_on:
      - db
      
  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: secret
    volumes:
      - db-data:/var/lib/mysql

volumes:
  db-data:
```

### Compose Befehle
```bash
# Services starten
docker-compose up -d

# Status prüfen
docker-compose ps

# Logs anzeigen
docker-compose logs -f

# Services stoppen
docker-compose down
```

# 7. Debugging & Troubleshooting
## 7.1 Container Debugging
```bash
# Interaktive Shell
docker exec -it container bash

# Prozesse im Container
docker top container

# Ressourcen-Nutzung
docker stats container

# Detaillierte Infos
docker inspect container
```

## 7.2 Logs & Monitoring
```bash
# Container Logs
docker logs -f container

# Events überwachen
docker events

# System-weite Infos
docker system df
docker system info
```

# 8. Best Practices
## 8.1 Security
```bash
# Non-Root User
docker run -u 1000:1000 nginx

# Read-only Filesystem
docker run --read-only nginx

# Security Scanning
docker scan my-image
```

## 8.2 Performance
```bash
# Cleanup
docker system prune -a

# Layer Optimierung
docker history my-image

# Build Cache nutzen
docker build --no-cache .
```

# Nützliche Einzeiler für den Workshop
```bash
# Alle Container stoppen
docker stop $(docker ps -aq)

# Alle Container löschen
docker rm $(docker ps -aq)

# Alle Images löschen
docker rmi $(docker images -q)

# Dangling Images finden
docker images -f "dangling=true" -q

# Container IP finden
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container

# Logs seit 5 Minuten
docker logs --since 5m container

# Top 10 größte Container
docker ps -s --sort=-size | head

# Container Statistiken
docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```

# Docker Compose Beispiel für Symfony
```yaml
# docker-compose.yml
version: '3.8'

services:
  nginx:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - ./:/var/www/html
      - ./docker/nginx/default.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - php

  php:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - ./:/var/www/html
    environment:
      PHP_IDE_CONFIG: "serverName=symfony"
      DATABASE_URL: "mysql://symfony:symfony@db/symfony"
    depends_on:
      - db

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: symfony
      MYSQL_USER: symfony
      MYSQL_PASSWORD: symfony
    volumes:
      - db-data:/var/lib/mysql
    ports:
      - "3306:3306"

volumes:
  db-data:
```

