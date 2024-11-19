**Lösungen**:

```yaml
# docker-compose.yml
services:
  php:
    build: 
      context: .
      target: symfony_php
      args:
        XDEBUG_MODE: '${XDEBUG_MODE:-off}'
    volumes:
      - .:/var/www/html
    environment:
      DATABASE_URL: mysql://root:secret@db:3306/symfony
    depends_on:
      db:
        condition: service_healthy

  nginx:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - .:/var/www/html
      - ./docker/nginx/conf.d:/etc/nginx/conf.d
    depends_on:
      - php

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: symfony
    volumes:
      - db-data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  db-data:

# Verwendung
docker-compose up -d
docker-compose ps
docker-compose logs -f
docker-compose down -v
```
