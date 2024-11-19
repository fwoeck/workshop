**Lösungen**:

```bash
# SSH Config für Multi-Hop
cat >> ~/.ssh/config << 'EOF'
Host jumphost
    HostName 10.111.62.205
    Port 42022
    User $USER

Host internal
    HostName 192.168.1.100
    ProxyJump jumphost
    User $USER
EOF

# Direkter Zugriff
ssh internal

# Mit Port-Forwarding
ssh -L 8080:localhost:80 -J jumphost internal

# Alternative mit altem Syntax
ssh -o ProxyCommand="ssh -W %h:%p jumphost" internal
```
