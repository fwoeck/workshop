## Aufgabe 8: Git Reflog und Recovery

**Schwierigkeit**: Fortgeschritten  

**Szenario**: Nach einem missglückten Rebase sind Commits "verschwunden".  

**Vorbereitung**:

- Führe diese Aufgaben bitte in diesem Verzeichnis aus.
  Checke den Feature-Branch `feature/ABC-123` aus. Führe dann einen hard-Reset
  auf origin/develop durch: git reset --hard origin/develop
  Dadurch geht das Commit "ABC-123" verloren.

**Aufgabe**:

- Finde die verlorenen Commits im Reflog
- Stelle den Branch-Zustand wieder her
- Erstelle einen Backup-Branch
- Führe den Rebase erneut durch
