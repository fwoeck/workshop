**Lösungen**:

```bash
# Basis-Analyse
awk '$9 == "404"' access.log | awk '{print $7}' | sort | uniq -c | sort -nr

# Mit Schwellwert
awk '$9 == "404"' access.log | awk '{print $7}' | sort | uniq -c | awk '$1 > 10' | sort -nr

# Mit formatierter Ausgabe
awk '$9 == "404"' access.log | awk '{print $7}' | sort | uniq -c | awk '$1 > 10 {printf "%-50s %s\n", $2, $1}' | sort -k 2 -nr
```
