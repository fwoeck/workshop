**Lösungen**:

```bash
# Netzwerk erstellen
docker network create symfony-net

# MySQL starten
docker run -d \
  --name symfony-db \
  --network symfony-net \
  -e MYSQL_ROOT_PASSWORD=secret \
  -e MYSQL_DATABASE=symfony \
  mysql:8.0

# PHP-FPM starten
docker run -d \
  --name symfony-php \
  --network symfony-net \
  -v $(pwd):/var/www/html \
  php:8.1-fpm

# Nginx starten
docker run -d \
  --name symfony-nginx \
  --network symfony-net \
  -v $(pwd):/var/www/html \
  -v ./nginx.conf:/etc/nginx/conf.d/default.conf \
  -p 8080:80 \
  nginx:alpine

# Logs überwachen
docker logs -f symfony-nginx &
docker logs -f symfony-php &
docker logs -f symfony-db
```
