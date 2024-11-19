**Lösungen**:

```bash
# Worktrees erstellen
git worktree add ../proj-feature feature/ABC-123
git worktree add ../proj-hotfix hotfix/XYZ-789

# Status überprüfen
git worktree list
git worktree list --porcelain

# Änderungen teilen
cd ../proj-feature
git add .
git commit -m "feat: Add new feature"
cd ../proj-hotfix
git cherry-pick feature/ABC-123

# Aufräumen
git worktree remove ../proj-hotfix
git worktree prune
```
