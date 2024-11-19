**Lösungen**:

```bash
# Basis-Lösung
find src/Controller -name "*.php" -type f | sort

# Nur Dateinamen
find src/Controller -name "*.php" -type f -printf "%f\n" | sort

# Nur Dateinamen
find src/Controller -name "*.php" -type f -exec basename {} \; | sort

# Mit Zusatzinformationen
find src/Controller -name "*.php" -type f -exec ls -lh {} \; | sort -k 9
```
