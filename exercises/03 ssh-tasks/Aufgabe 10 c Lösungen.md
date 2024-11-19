**Lösungen**:

```bash
# Auf Bastion Host: Authorized Keys mit Einschränkungen
cat >> ~/.ssh/authorized_keys << 'EOF'
command="./audit-wrapper.sh $SSH_ORIGINAL_COMMAND",no-port-forwarding,
no-x11-forwarding,no-agent-forwarding ssh-ed25519 AAAA... user@host
EOF

# Audit Wrapper Script
cat > audit-wrapper.sh << 'EOF'
#!/bin/bash
timestamp=$(date '+%Y-%m-%d %H:%M:%S')
echo "$timestamp $USER $SSH_ORIGINAL_COMMAND" >> /var/log/ssh-audit.log

case "$SSH_ORIGINAL_COMMAND" in
    "uptime"|"df -h"|"free -m")
        eval $SSH_ORIGINAL_COMMAND
        ;;
    *)
        echo "Command not allowed"
        exit 1
        ;;
esac
EOF
chmod +x audit-wrapper.sh

# Client SSH Config
cat >> ~/.ssh/config << 'EOF'
Host * !bastion
    ProxyJump bastion
    UserKnownHostsFile ~/.ssh/known_hosts.d/%h

Host bastion
    HostName 10.111.62.205
    Port 42022
    User $USER
    IdentityFile ~/.ssh/id_ed25519
    StrictHostKeyChecking yes
EOF
```
