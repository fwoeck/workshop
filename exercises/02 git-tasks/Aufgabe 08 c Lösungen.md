**Lösungen**:

```bash
# Verloren Commits finden
git reflog
git log -g

# Wiederherstellung
git reflog
git checkout -b backup/feature-abc-123 HEAD@{2}

# Mit Cherry-Pick
git reflog
git cherry-pick HEAD@{2}..HEAD@{0}

# Mit Reset
git reflog
git reset --hard HEAD@{2}
```
