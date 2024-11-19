**Lösungen**:

```bash
# Remote hinzufügen und synchronisieren
git remote add upstream git@github.com:yourUser/repo.git
git fetch --all
git branch -va

# Mit spezifischen Branches
git fetch upstream develop
git checkout feature/ABC-123
git rebase upstream/develop
git push -u upstream feature/ABC-123

# Mit Force-Push (wenn nötig)
git fetch upstream develop
git rebase upstream/develop
git push -u --force-with-lease upstream feature/ABC-123
```
