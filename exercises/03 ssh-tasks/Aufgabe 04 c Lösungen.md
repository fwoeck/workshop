**Lösungen**:

```bash
# Basis-Synchronisation
rsync -avz --progress ./projekt/ devserver:/var/www/projekt/

# Mit Ausschlüssen
rsync -avz --progress \
  --exclude 'vendor/' \
  --exclude 'node_modules/' \
  --exclude '.git/' \
  ./projekt/ devserver:/var/www/projekt/

# Mit zusätzlichen Optionen
rsync -avz --progress \
  --exclude-from='.gitignore' \
  --delete \
  --backup --backup-dir=/tmp/rsync-backup \
  ./projekt/ devserver:/var/www/projekt/
```
