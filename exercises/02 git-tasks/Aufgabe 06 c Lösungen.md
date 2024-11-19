**Lösungen**:

```bash
# Remote hinzufügen und synchronisieren
git remote add upstream git@github.com:org/repo.git
git fetch --all
git branch -va

# Mit spezifischen Branches
git fetch upstream develop
git checkout feature/ABC-123
git rebase upstream/develop
git push origin feature/ABC-123

# Mit Force-Push (wenn nötig)
git fetch upstream develop
git rebase upstream/develop
git push --force-with-lease origin feature/ABC-123
```
