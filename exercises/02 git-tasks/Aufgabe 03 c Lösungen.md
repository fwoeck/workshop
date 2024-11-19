**Lösungen**:

```bash
# Änderungen überprüfen
git status
git diff

# Interaktives Staging
git add -p src/Controller/UserController.php
git diff --staged  # Überprüfen was gestaged ist
git commit -m "feat: Implement user validation in backend"

# Frontend-Änderungen separat committen
git add assets/js/
git commit -m "feat: Add user form validation in frontend"
```
