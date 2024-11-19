**Lösungen**:

```bash
#!/bin/bash
# backup.sh
# SSH Tunnel aufbauen
ssh -fN -L 13306:localhost:3306 devserver

# Warten bis Tunnel steht
sleep 2

# Backup-Verzeichnis
BACKUP_DIR="/backup/$(date +%Y-%m-%d)"
mkdir -p "$BACKUP_DIR"

# Datenbank sichern
mysqldump -h 127.0.0.1 -P 13306 -u user -p'pass' database > \
  "$BACKUP_DIR/database.sql"

# Dateien synchronisieren
rsync -avz --delete \
  --exclude 'var/cache/' \
  --exclude 'var/log/' \
  devserver:/var/www/projekt/ \
  "$BACKUP_DIR/files/"

# Tunnel schließen
ssh -O stop devserver

# Alte Backups rotieren (behalte 7 Tage)
find /backup -type d -mtime +7 -exec rm -rf {} \;
```
