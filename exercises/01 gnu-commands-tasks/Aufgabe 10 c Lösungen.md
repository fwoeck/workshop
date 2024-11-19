**Lösungen**:

```bash
# Einfaches Monitoring
watch -n 5 'ps aux | awk '\''
  BEGIN {printf "%-20s %8s %8s\n", "PROCESS", "CPU%", "MEM%"}
  NR>1 {printf "%-20s %8.1f %8.1f\n", substr($11,1,20), $3, $4}
'\'' | sort -k2 -nr | head -n 10'

# Mit Logging
while true; do
  date '+%Y-%m-%d %H:%M:%S' >> monitor.log
  top -b -n 1 | head -n 12 >> monitor.log
  sleep 5
done

# Komplexes Monitoring mit Alarming
#!/bin/bash
while true; do
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
  mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
  disk_io=$(iostat -x 1 1 | tail -n 2 | head -n 1 | awk '{print $14}')
  
  echo "$timestamp;$cpu_usage;$mem_usage;$disk_io" >> metrics.csv
  
  if (( $(echo "$cpu_usage > 80" | bc -l) )); then
    echo "HIGH CPU ALERT: $cpu_usage%" | tee -a alerts.log
  fi
  
  if (( $(echo "$mem_usage > 90" | bc -l) )); then
    echo "HIGH MEMORY ALERT: $mem_usage%" | tee -a alerts.log
  fi
  
  sleep 5
done
```
