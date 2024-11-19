**Lösungen**:

```bash
# SSH Config für Multiplexing
cat >> ~/.ssh/config << 'EOF'
Host devserver
    ControlMaster auto
    ControlPath ~/.ssh/control:%h:%p:%r
    ControlPersist 10m
    ServerAliveInterval 60
EOF

# Initiale Verbindung
ssh devserver

# Neue Verbindung (nutzt bestehende)
ssh devserver 'uptime'

# Verbindungen überprüfen
ssh -O check devserver

# Verbindungen beenden
ssh -O stop devserver
```
