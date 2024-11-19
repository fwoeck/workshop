**Lösungen**:

```bash
# Gestoppte Container entfernen
docker container prune

# Ungenutzte Images entfernen
docker image prune -a

# Volumes bereinigen
docker volume prune

# System bereinigen
docker system prune -a --volumes

# Selektives Cleanup
docker ps -a | grep "Exit" | cut -d ' ' -f 1 | xargs docker rm
docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi
```
