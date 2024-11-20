# SSH Workshop - Theoretische Grundlagen

# 1. SSH Grundkonzepte
## 1.1 Was ist SSH?
- Secure Shell Protokoll
- Verschlüsselte Verbindung
- Authentifizierung
- Tunneling & Forwarding

### Grundlegende Syntax
```bash
# Basis SSH-Verbindung
ssh benutzer@hostname

# Mit Port
ssh -p 2222 benutzer@hostname

# Verbose Mode für Debugging
ssh -v benutzer@hostname
```

## 1.2 Authentifizierungsmethoden
### Passwort-Authentication
```bash
# Explizite Passwort-Authentifizierung
ssh -o PreferredAuthentications=password user@host
```

### Public Key Authentication
```bash
# Key generieren (Ed25519 - modern)
ssh-keygen -t ed25519 -C "user@company"

# Key generieren (RSA - traditionell, min. 2048 bit)
ssh-keygen -t rsa -b 4096 -C "user@company"

# Public Key auf Server kopieren
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@host
```

## 1.3 SSH-Konfiguration
### Client Konfiguration (~/.ssh/config)
```bash
# Basis-Konfiguration
Host myserver
    HostName 192.168.1.100
    User myuser
    Port 2222
    IdentityFile ~/.ssh/id_ed25519

# Verbindung testen
ssh myserver
```

### Server Konfiguration (/etc/ssh/sshd_config)
```bash
# Wichtige Server-Einstellungen
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
Port 2222
```

# 2. Dateitransfer mit SSH
## 2.1 SCP (Secure Copy)
### Basis-Operationen
```bash
# Datei auf Server kopieren
scp local.txt user@host:~/

# Datei vom Server holen
scp user@host:~/remote.txt ./

# Verzeichnis rekursiv kopieren
scp -r localdir/ user@host:~/
```

### Erweiterte Optionen
```bash
# Mit Kompression und Fortschrittsanzeige
scp -Crp localdir/ user@host:~/

# Spezifischer Port
scp -P 2222 local.txt user@host:~/

# Berechtigungen beibehalten
scp -p local.txt user@host:~/
```

## 2.2 RSYNC über SSH
### Basis-Synchronisation
```bash
# Verzeichnis synchronisieren
rsync -av ./local/ user@host:~/remote/

# Mit Kompression
rsync -avz ./local/ user@host:~/remote/

# Mit Fortschrittsanzeige
rsync -avz --progress ./local/ user@host:~/remote/
```

### Erweiterte Optionen
```bash
# Mit Ausschlüssen
rsync -avz --exclude 'node_modules' --exclude '*.tmp' ./local/ user@host:~/remote/

# Mit Löschung auf Ziel
rsync -avz --delete ./local/ user@host:~/remote/

# Mit Backup
rsync -avz --backup --backup-dir=/backup ./local/ user@host:~/remote/
```

# 3. SSH Tunneling
## 3.1 Port Forwarding
### Local Forwarding (Client zu Server)
```bash
# MySQL-Port weiterleiten
ssh -L 13306:localhost:3306 user@host

# Im Hintergrund
ssh -fNL 13306:localhost:3306 user@host

# Mit Konfiguration
Host mysql-tunnel
    HostName server.example.com
    LocalForward 13306 localhost:3306
```

### Remote Forwarding (Server zu Client)
```bash
# Remote Port Forwarding
ssh -R 8080:localhost:80 user@host

# Permanent in Config
Host remote-web
    HostName server.example.com
    RemoteForward 8080 localhost:80
```

## 3.2 SOCKS Proxy
```bash
# SOCKS Proxy erstellen
ssh -D 1080 user@host

# Mit Konfiguration
Host proxy
    HostName server.example.com
    DynamicForward 1080
```

# 4. SSH Agent und Key Management
## 4.1 SSH Agent
### Agent Verwaltung
```bash
# Agent starten
eval $(ssh-agent)

# Key hinzufügen
ssh-add ~/.ssh/id_ed25519

# Keys auflisten
ssh-add -l

# Alle Keys entfernen
ssh-add -D
```

### Agent Forwarding
```bash
# Mit Kommandozeile
ssh -A user@host

# In Config
Host myserver
    ForwardAgent yes
```

## 4.2 Key Management
### Key-Typen und Sicherheit
```bash
# Sicheren Key generieren
ssh-keygen -t ed25519 -a 100

# Key-Fingerprint anzeigen
ssh-keygen -lf ~/.ssh/id_ed25519

# Public Key extrahieren
ssh-keygen -y -f ~/.ssh/id_ed25519
```

# 5. Fortgeschrittene Konzepte
## 5.1 Multiplexing
### Connection Sharing
```bash
# In SSH Config
Host *
    ControlMaster auto
    ControlPath ~/.ssh/control:%h:%p:%r
    ControlPersist 10m

# Verbindung prüfen
ssh -O check host

# Verbindung beenden
ssh -O stop host
```

## 5.2 Jump Hosts
### Multi-Hop SSH
```bash
# Via Kommandozeile
ssh -J jumphost user@targethost

# In Config
Host target
    HostName 192.168.1.100
    ProxyJump jumphost
```

## 5.3 Bastion Hosts
### Sichere Konfiguration
```bash
# Restricted Command in authorized_keys
command="allowed_command.sh",no-port-forwarding,no-x11-forwarding ssh-ed25519 AAA...

# Audit Script
#!/bin/bash
logger -p auth.info "User $USER executed: $SSH_ORIGINAL_COMMAND"
```

# 6. Best Practices
## 6.1 Sicherheit
### Key-Sicherheit
```bash
# Rechte setzen
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# Known Hosts überprüfen
ssh-keygen -H -F hostname
```

### Server Härtung
```bash
# SSH Config sichern
# /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no
MaxAuthTries 3
LoginGraceTime 30
```

## 6.2 Performance
### Verbindungsoptimierung
```bash
# In SSH Config
Host *
    Compression yes
    TCPKeepAlive yes
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

# Nützliche Einzeiler für den Workshop
```bash
# SSH-Verbindung testen
ssh -T git@github.com

# Alle aktiven SSH-Verbindungen anzeigen
ps aux | grep ssh

# SSH-Key Fingerprint anzeigen
ssh-keygen -lf ~/.ssh/id_ed25519.pub

# Alle SSH-Schlüssel auflisten
for key in ~/.ssh/id_*; do ssh-keygen -lf "${key}"; done

# SSH-Verbindungstest mit Timeout
timeout 5 ssh -q user@host exit

# Known Hosts Eintrag entfernen
ssh-keygen -R hostname

# SSH Debug-Modus
ssh -vvv user@host
```

# SSH Konfigurationsbeispiele
```bash
# ~/.ssh/config Beispiel für Entwicklungsumgebung

# Default-Einstellungen
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 3
    TCPKeepAlive yes
    Compression yes

# Entwicklungsserver
Host devserver
    HostName 192.168.1.100
    User developer
    Port 2222
    IdentityFile ~/.ssh/dev_ed25519
    ForwardAgent yes

# Staging mit Jump Host
Host staging
    HostName 10.0.0.100
    ProxyJump jumphost
    User deployer
    IdentityFile ~/.ssh/staging_ed25519

# Datenbank-Tunnel
Host dbtunnel
    HostName dbserver.example.com
    LocalForward 13306 localhost:3306
    User dbuser
    IdentityFile ~/.ssh/db_ed25519
```
