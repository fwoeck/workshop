**Lösungen**:

```bash
# Volume erstellen
docker volume create mysql-data

# Container mit Volume starten
docker run -d \
  --name project-db \
  -v mysql-data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=secret \
  mysql:8.0

# Volume inspizieren
docker volume inspect mysql-data

# Persistenz testen
docker exec -it project-db mysql -uroot -psecret -e "CREATE DATABASE test;"
docker rm -f project-db
docker run -d \
  --name project-db-new \
  -v mysql-data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=secret \
  mysql:8.0
docker exec -it project-db-new mysql -uroot -psecret -e "SHOW DATABASES;"
```
