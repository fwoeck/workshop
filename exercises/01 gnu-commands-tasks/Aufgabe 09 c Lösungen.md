**Lösungen**:

```bash
# Basis-Analyse
awk '{sum[$7]+=$NF; count[$7]++} END { for(url in sum) printf "%-50s %8.2f ms\n", url, sum[url]/count[url] }' requests.log | sort -k2 -nr

# Mit Filterung
awk '{sum[$7]+=$NF; count[$7]++} 
     END {
       for(url in sum) {
         avg=sum[url]/count[url];
         if(avg > 1000)
           printf "%-50s %8.2f ms (calls: %d)\n", url, avg, count[url]
       }
     }' requests.log | sort -k2 -nr

# Mit zusätzlicher Statistik
awk '{
       url=$7
       time=$NF
       sum[url]+=time
       count[url]++
       if(time > max[url]) max[url]=time
     } 
     END {
       printf "%-50s %8s %8s %8s %8s\n", "URL", "AVG", "MAX", "CALLS", "TOTAL"
       for(url in sum) {
         avg=sum[url]/count[url]
         if(avg > 1000)
           printf "%-50s %8.2f %8.2f %8d %8.2f\n", 
                  url, avg, max[url], count[url], sum[url]
       }
     }' requests.log | sort -k2 -nr
```
