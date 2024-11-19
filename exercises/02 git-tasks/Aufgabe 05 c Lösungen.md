**Lösungen**:

```bash
# Basis-Ablauf
git checkout develop
git pull
git checkout feature/ABC-123
git rebase develop

# Mit Konfliktlösung
git checkout develop
git pull
git checkout feature/ABC-123
git rebase develop

# Wenn Konflikte auftreten:
git status  # Zeigt konfliktbehaftete Dateien

# Dateien editieren
git mergetool
git rebase --continue

# Optional:
git log --graph --oneline --all

# Mit Abbruch-Option
git rebase --abort
```
