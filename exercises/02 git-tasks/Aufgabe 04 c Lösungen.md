**Lösungen**:

```bash
# Historie anzeigen
git log -5 --oneline

# Interaktives Rebase
git rebase -i HEAD~5

# Mit Commit-Message-Template
git rebase -i HEAD~5
# Im Editor: squash oder fixup für WIP-Commits
# Neue Message nach Convention:
# feat: Implement user management
# 
# - Add user validation
# - Create user form
# - Implement API endpoint

# Mit Backup-Branch
git branch backup/feature-abc-123
git rebase -i HEAD~5
```
