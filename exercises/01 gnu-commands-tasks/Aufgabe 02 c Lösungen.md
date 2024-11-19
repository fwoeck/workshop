**Lösungen**:

```bash
# Fehler finden
grep "ERROR" var/log/dev.log

# Fehler zählen
grep -c "ERROR" var/log/dev.log

# Letzte 5 Fehler
grep "ERROR" var/log/dev.log | tail -n 5
```
