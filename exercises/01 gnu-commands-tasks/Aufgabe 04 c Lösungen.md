**Lösungen**:

```bash
# Grundlegende Bereinigung
sed '/^$/d' users.csv | sed 's/,/;/g' | tr '[:upper:]' '[:lower:]'

# Alternative mit awk
awk 'NF' users.csv | sed 's/,/;/g' | tr '[:upper:]' '[:lower:]'

# Mit Zwischenspeicherung
sed '/^$/d' users.csv | sed 's/,/;/g' | tr '[:upper:]' '[:lower:]' > users_clean.csv
```
