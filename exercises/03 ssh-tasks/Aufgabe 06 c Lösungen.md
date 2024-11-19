**Lösungen**:

```bash
# Agent starten
eval $(ssh-agent)

# Keys hinzufügen
ssh-add ~/.ssh/id_ed25519
ssh-add ~/.ssh/id_project2

# Mit Zeitbegrenzung
ssh-add -t 3600 ~/.ssh/id_ed25519

# Agent-Forwarding in Config
cat >> ~/.ssh/config << 'EOF'
Host devserver
    ForwardAgent yes
EOF

# Test auf Server
ssh devserver 'ssh-add -l'
```
