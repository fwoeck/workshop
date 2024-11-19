**Lösungen**:

```bash
# Große Dateien finden
find . -type f -size +3k

# Mit Dateityp-Gruppierung
find . -type f -size +3k -exec file {} \; | awk -F: '{print $2}' | sort | uniq -c

# Mit Größenberechnung
find . -type f -size +3k -exec du -sh {} \; | sort -hr
```
