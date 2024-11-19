**Lösungen**:

```bash
# Einfacher Pre-commit Hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
set -e

# Check für Debugging
if grep -r "var_dump\|dump(" "./exercises/02\ git-tasks/src/"; then
  echo "ERROR: Found debugging statements"
  exit 1
fi
EOF
chmod +x .git/hooks/pre-commit

# Mit Commit-Message Hook
cat > .git/hooks/commit-msg << 'EOF'
#!/bin/bash
set -e

# Validate commit message format
if ! grep -qE "^(feat|fix|docs|style|refactor|test|chore):" $1; then
  echo "ERROR: Invalid commit message format"
  echo "Must start with type: feat|fix|docs|style|refactor|test|chore"
  exit 1
fi
EOF
chmod +x .git/hooks/commit-msg
```
