**Lösungen**:

```bash
# SSH Config erstellen/ergänzen
cat >> ~/.ssh/config << 'EOF'
Host devserver
    HostName 10.111.62.205
    Port 42022
    User $USER
    IdentityFile ~/.ssh/id_ed25519
EOF

# Berechtigung setzen
chmod 600 ~/.ssh/config

# Verbindung testen
ssh devserver

# Alternative mit expliziten Parametern
ssh -p 42022 $USER@10.111.62.205
```
