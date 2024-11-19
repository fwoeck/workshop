**Lösungen**:

```bash
# Basis-Ausgabe
ps aux | grep mdworker

# Sortiert nach Memory
ps aux | grep mdworker | sort -k 4 -r

# Formatierte Ausgabe
ps aux | grep mdworker | awk '{printf "PID: %s MEM: %s CPU: %s CMD: %s\n", $2, $4, $3, $11}' | sort -k 3 -r

# Basis-Ausgabe ohne grep
ps aux | grep [m]dworker | awk '{printf "PID: %s MEM: %s CPU: %s CMD: %s\n", $2, $4, $3, $11}' | sort -k 3 -r
```
