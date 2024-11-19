**Lösungen**:

```bash
# Container starten
docker run -d \
  --name project-db \
  -e MYSQL_ROOT_PASSWORD=secret \
  -e MYSQL_DATABASE=symfony \
  -p 3306:3306 \
  mysql:8.0

# Logs überprüfen
docker logs project-db
docker logs -f project-db

# Container Status
docker ps
docker inspect project-db

# Container stoppen und löschen
docker stop project-db
docker rm project-db

# Alles in einem Befehl
docker rm -f project-db
```
