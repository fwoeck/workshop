## Aufgabe 10: System-Monitoring

**Schwierigkeit**: Experte  

**Szenario**: Kontinuierliches Monitoring von System-Ressourcen.  

**Aufgabe**:

! Führe die Kommandos bitte im Docker-Container aus.
  Du kannst parallel mehrere Befehle "docker-compose exec workshop bash" starten,
  um mehrere Prozesse zu simulieren. Last erzeugen, z.B.:
  while true; do echo "scale=10000; 4*a(1)" | bc -l; done

- Überwache CPU, Memory und Disk-IO
- Protokolliere Werte alle 5 Sekunden
- Alarmiere bei Überschreitung von Schwellwerten
- Speichere in strukturiertem Format
