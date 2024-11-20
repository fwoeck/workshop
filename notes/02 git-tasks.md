# Git Workshop - Theoretische Grundlagen

# 1. Git Grundkonzepte
## 1.1 Lokale Versionierung
### Drei Zustände von Git
- Working Directory (untracked/modified)
- Staging Area (staged)
- Git Directory (committed)

```bash
# Status der drei Bereiche anzeigen
git status

# Änderungen zwischen Working Directory und Staging
git diff

# Änderungen zwischen Staging und Repository
git diff --staged
```

### Git Objects
- Blobs (Dateiinhalte)
- Trees (Verzeichnisstrukturen)
- Commits (Snapshots)
- Tags (benannte Referenzen)

```bash
# Git-Objekte anzeigen
git cat-file -t <hash>  # Typ anzeigen
git cat-file -p <hash>  # Inhalt anzeigen
```

## 1.2 Branching-Konzept
### Branch als Zeiger
- Branch ist nur ein Zeiger auf einen Commit
- HEAD zeigt auf aktuellen Branch
- Detached HEAD State

```bash
# Alle Branches anzeigen
git branch -vv

# HEAD-Position anzeigen
git rev-parse HEAD

# Branch erstellen und wechseln
git checkout -b feature/new-branch
```

### Branch-Workflows
- Feature Branch Workflow
- GitFlow
- Trunk-Based Development

```bash
# Feature Branch erstellen
git checkout -b feature/ABC-123-description develop

# Branch aktualisieren
git pull origin develop
git rebase develop
```

# 2. Grundlegende Operationen
## 2.1 Änderungen verwalten
### Staging Area nutzen
```bash
# Alle Änderungen stagen
git add .

# Selektiv stagen
git add -p file.txt

# Staging rückgängig machen
git restore --staged file.txt
```

### Commits erstellen
```bash
# Einfacher Commit
git commit -m "feat: Add user validation"

# Änderungen nachträglich zum letzten Commit hinzufügen
git commit --amend

# Commit mit detaillierter Message
git commit
```

## 2.2 Historie verwalten
### Log anzeigen
```bash
# Standard Log
git log

# Kompaktes Log
git log --oneline

# Grafische Darstellung
git log --graph --decorate --all
```

### Änderungen nachverfolgen
```bash
# Wer hat was geändert
git blame file.txt

# Änderungsverlauf einer Datei
git log -p file.txt

# Änderungen zwischen Commits
git diff commit1..commit2
```

# 3. Fortgeschrittene Konzepte
## 3.1 Rebase vs. Merge
### Merge
- Erstellt neuen Merge-Commit
- Behält vollständige Historie
- Gut für Feature-Branches

```bash
# Merge durchführen
git checkout main
git merge feature/xyz

# Merge mit Message
git merge feature/xyz -m "feat: Merge user management"
```

### Rebase
- Schreibt Historie um
- Lineare Historie
- Gut für Feature-Branches vor PR

```bash
# Rebase durchführen
git checkout feature/xyz
git rebase main

# Interaktiver Rebase
git rebase -i HEAD~3
```

## 3.2 Konfliktlösung
### Konflikte erkennen
```bash
# Status während Merge-Konflikten
git status

# Konfliktbehaftete Dateien anzeigen
git diff --name-only --diff-filter=U
```

### Konflikte lösen
```bash
# Konflikte manuell lösen und stagen
git add resolved-file.txt
git merge --continue

# Merge abbrechen
git merge --abort

# Rebase abbrechen
git rebase --abort
```

## 3.3 Stashing
### Temporäres Speichern
```bash
# Änderungen stashen
git stash

# Benannter Stash
git stash save "WIP: Feature XYZ"

# Stash anwenden
git stash pop

# Stash Liste
git stash list
```

# 4. Remote-Operationen
## 4.1 Remote-Verwaltung
### Remotes verwalten
```bash
# Remotes anzeigen
git remote -v

# Remote hinzufügen
git remote add upstream git@github.com:org/repo.git

# Remote aktualisieren
git remote set-url origin new-url
```

### Fetch und Pull
```bash
# Alle Remotes aktualisieren
git fetch --all

# Spezifischen Branch pullen
git pull origin main

# Rebase beim Pull
git pull --rebase origin main
```

## 4.2 Push-Strategien
### Sicheres Pushen
```bash
# Normaler Push
git push origin feature/xyz

# Force Push mit Lease (sicher)
git push --force-with-lease origin feature/xyz

# Upstream setzen
git push -u origin feature/xyz
```

# 5. Git Workflow Tools
## 5.1 Git Hooks
### Lokale Hooks
```bash
# Pre-commit Hook aktivieren
chmod +x .git/hooks/pre-commit

# Commit-msg Hook
chmod +x .git/hooks/commit-msg
```

## 5.2 Worktree
### Parallele Arbeit
```bash
# Worktree erstellen
git worktree add ../feature-123 feature/123

# Worktrees auflisten
git worktree list

# Worktree entfernen
git worktree remove ../feature-123
```

## 5.3 Bisect
### Bug-Suche
```bash
# Bisect starten
git bisect start
git bisect bad HEAD
git bisect good v1.0.0

# Automatisierte Suche
git bisect run ./test.sh
```

# 6. Best Practices
## 6.1 Commit Messages
### Conventional Commits
```bash
# Format
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]

# Beispiel
feat(auth): Add OAuth2 authentication

- Implement Google OAuth provider
- Add user token management
- Update login flow

Closes #123
```

## 6.2 Branch-Management
### Branch-Hygiene
```bash
# Verwaiste Branches finden
git branch -vv | grep ': gone]'

# Lokale Branches aufräumen
git fetch -p
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d

# Remote Branches analysieren
git remote prune origin --dry-run
```

## 6.3 Sicherheit
### Sensible Daten
```bash
# History bereinigen (VORSICHT!)
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch config/secrets.yml" \
  --prune-empty --tag-name-filter cat -- --all

# Git-ignore aktualisieren
echo "config/secrets.yml" >> .gitignore
```

# Nützliche Aliase für den Workshop
```bash
# Git-Konfiguration
git config --global alias.st "status -sb"
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.unstage "restore --staged"
git config --global alias.last "log -1 HEAD"
git config --global alias.amend "commit --amend --no-edit"
```
