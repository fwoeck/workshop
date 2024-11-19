**Lösungen**:

```bash
# Einfacher Tunnel
ssh -L 13306:localhost:3306 devserver

# Tunnel im Hintergrund
ssh -fN -L 13306:localhost:3306 devserver

# Mit spezifischer Konfiguration
cat >> ~/.ssh/config << 'EOF'
Host devserver-mysql
    HostName 10.111.62.205
    Port 42022
    User $USER
    LocalForward 13306 127.0.0.1:3306
EOF

# Tunnel via Config
ssh -fN devserver-mysql

# Verbindung testen
mysql -h 127.0.0.1 -P 13306 -u user -p
```
