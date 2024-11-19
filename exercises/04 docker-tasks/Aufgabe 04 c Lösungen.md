**Lösungen**:

```bash
# Netzwerk erstellen
docker network create project-net

# MySQL im Netzwerk starten
docker run -d \
  --name project-db \
  --network project-net \
  -e MYSQL_ROOT_PASSWORD=secret \
  mysql:8.0

# PHP-Container hinzufügen
docker run -d \
  --name project-php \
  --network project-net \
  -v $(pwd):/var/www \
  php:8.1-fpm

# Netzwerk analysieren
docker network inspect project-net

# Verbindung testen
docker exec project-php bash -c 'php -r "new PDO(\"mysql:host=project-db;dbname=mysql\", \"root\", \"secret\");"'
```
