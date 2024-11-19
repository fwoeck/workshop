**Lösungen**:

```bash
# Container-Status und Logs
docker inspect symfony-php
docker logs symfony-php

# Interaktive Shell
docker exec -it symfony-php bash

# Ressourcen überwachen
docker stats symfony-php

# Mit spezifischem Benutzer debuggen
docker exec -it -u www-data symfony-php bash

# Health-Check hinzufügen
docker run -d \
  --name symfony-php \
  --health-cmd='php -v || exit 1' \
  --health-interval=30s \
  php:8.1-fpm

# Health-Status prüfen
docker inspect --format='{{.State.Health.Status}}' symfony-php
```
