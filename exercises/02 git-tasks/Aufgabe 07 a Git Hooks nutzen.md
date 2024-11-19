## Aufgabe 7: Git Hooks nutzen

**Schwierigkeit**: Fortgeschritten  

**Szenario**: Automatisiere Qualitätschecks vor dem Commit.  

**Vorbereitung**:

- Führe diese Aufgaben bitte in diesem (root-)Verzeichnis aus.

**Aufgabe**:

- Erstelle einen pre-commit Hook
- Prüfe auf versehentlich commitete Debugging-Statements in "./exercises/02 git-tasks/src/"
- Validiere Commit-Messages, z.B.: Must start with: feat|fix|docs|style|refactor|test|chore
