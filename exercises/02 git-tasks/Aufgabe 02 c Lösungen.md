**Lösungen**:

```bash
# Basis-Variante
git checkout develop
git pull
git checkout -b feature/ABC-123-kurze-beschreibung

# Mit Überprüfung des Remote-Status
git checkout develop
git fetch origin
git reset --hard origin/develop
git checkout -b feature/ABC-123-kurze-beschreibung

# Mit Branch-Validierung
git checkout develop
git pull
git check-ref-format --branch feature/ABC-123-kurze-beschreibung && 
git checkout -b feature/ABC-123-kurze-beschreibung
```
