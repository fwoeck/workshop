**Lösungen**:

```bash
# Schlüsselpaar erstellen
ssh-keygen -t ed25519 -C "$USER@company-dev"

# Key kopieren (Variante 1)
ssh-copy-id -i ~/.ssh/id_ed25519.pub devserver

# Key kopieren (Variante 2)
cat ~/.ssh/id_ed25519.pub | ssh devserver 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'

# Berechtigung auf dem Server prüfen
ssh devserver "chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"
```
