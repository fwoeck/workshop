**Lösungen**:

```bash
# Einfacher Vergleich
diff config_staging.yml config_prod.yml

# Übersichtlicher Vergleich
diff -y config_staging.yml config_prod.yml

# Unterschiede speichern
diff config_staging.yml config_prod.yml > config_diff.txt
```
