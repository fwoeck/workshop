**Lösungen**:

```bash
# Einzelne Datei kopieren
scp -P 42022 config.php $USER@10.111.62.205:/var/www/config/

# Mit Host-Alias aus SSH-Config
scp config.php devserver:/var/www/config/

# Verzeichnis rekursiv kopieren
scp -r -p local/config/ devserver:/var/www/

# Mit Fortschrittsanzeige und Kompression
scp -r -p -C -v local/config/ devserver:/var/www/
```
