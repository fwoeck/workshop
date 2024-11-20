# Shell Workshop - Theoretische Grundlagen mit Beispielen

# 1. Grundkonzepte des Linux-Systems
## 1.1 Filesystem
### Konzept der Files/Verzeichnisse unter Linux
```bash
# Verzeichnisstruktur anzeigen
tree /home/user
```

### Filesystem Hierarchy Standard (FHS)
```bash
# Wichtige Verzeichnisse anzeigen
ls -l /
ls -l /etc    # Konfigurationsdateien
ls -l /var    # Variable Daten
ls -l /opt    # Optionale Software
```

### Absolute vs. relative Pfade
```bash
# Absoluter Pfad
cd /home/user/documents

# Relativer Pfad
cd ../documents
cd ./subfolder
```

### Working Directory (PWD)
```bash
# Aktuelles Verzeichnis anzeigen
pwd

# In Unterverzeichnis wechseln
cd subdir && pwd
```

### Symbolische und harte Links
```bash
# Symbolischen Link erstellen
ln -s target_file link_name

# Harten Link erstellen
ln target_file link_name

# Links anzeigen
ls -l link_name
```

## 1.2 Berechtigungen
### Benutzer und Gruppen
```bash
# Aktuelle Benutzer-/Gruppeninformationen
id
groups

# Alle Gruppen anzeigen
getent group
```

### Konzept der Zugriffsrechte
```bash
# Dateirechte anzeigen
ls -l file.txt

# Verzeichnisrechte anzeigen
ls -ld /path/to/dir
```

### chmod und chown
```bash
# Rechte ändern
chmod u+x script.sh      # Ausführbar für User
chmod 755 script.sh      # Oktal-Notation
chmod -R g+w directory   # Rekursiv

# Besitzer ändern
chown user:group file.txt
```

### Besondere Rechte
```bash
# SUID setzen
chmod u+s binary_file

# SGID setzen
chmod g+s shared_directory

# Sticky Bit setzen
chmod +t public_directory
```

## 1.3 Prozesse
### Prozesskonzept in Linux
```bash
# Prozessbaum anzeigen
pstree

# Prozessinformationen
ps aux
```

### Prozesshierarchie
```bash
# Parent-Child Beziehungen anzeigen
ps f

# Prozess mit Children anzeigen
ps -ejH
```

### Vorder- und Hintergrundprozesse
```bash
# Prozess im Hintergrund starten
long_running_command &

# Prozess in Vordergrund holen
fg %1

# In Hintergrund schieben
bg %1
```

# 2. Shell Grundlagen
## 2.1 Ein- und Ausgabe
### STDIN, STDOUT, STDERR
```bash
# Standard Output umleiten
echo "Hello" > output.txt

# Standard Error umleiten
command 2> error.log

# Beide umleiten
command > output.txt 2> error.log
```

### Pipes
```bash
# Output weiterleiten
ps aux | grep nginx
ls -l | sort -k 5 -n
```

### Here-Documents
```bash
# Here-Document Beispiel
cat << EOF > config.txt
server {
    listen 80;
    server_name example.com;
}
EOF
```

## 2.2 Shell-Variablen und Umgebung
### Wichtige Bash-Variablen
```bash
# Variablen anzeigen/nutzen
echo $PWD
echo $HOME
echo $PATH

# Prozess-bezogene Variablen
echo $?  # Letzter Exit-Code
echo $$  # Aktuelle Prozess-ID
echo $!  # Letzte Hintergrund-Prozess-ID
```

### env und export
```bash
# Umgebungsvariablen anzeigen
env

# Variable exportieren
export MY_VAR="value"

# Temporäre Umgebung
MY_VAR="temp" command
```

# 3. Grundlegende Kommandos
## 3.1 Dateisystem-Navigation
```bash
# Grundlegende Navigation
pwd
cd /path/to/dir
ls -la

# Verzeichnisse erstellen/löschen
mkdir -p new/sub/dir
rmdir empty_dir
rm -rf filled_dir

# Dateien suchen
find . -name "*.php" -type f
locate filename
```

## 3.2 Dateioperationen
### Basis-Operationen
```bash
# Datei anzeigen
cat file.txt
less file.txt
head -n 5 file.txt
tail -f log.txt

# Datei analysieren
wc -l file.txt
sort file.txt | uniq -c
```

### grep und reguläre Ausdrücke
```bash
# Text suchen
grep "pattern" file.txt
grep -r "pattern" .
grep -E "regex|pattern" file.txt
```

### sed und awk
```bash
# Text ersetzen mit sed
sed 's/old/new/g' file.txt
sed -i.bak 's/old/new/g' file.txt  # Mit Backup

# Felder verarbeiten mit awk
awk '{print $1}' file.txt
awk '{sum += $1} END {print sum}' numbers.txt
```

## 3.3 Systeminformationen
```bash
# Prozesse anzeigen
ps aux
top
htop

# Speicherplatz
df -h
du -sh *

# System-Load
uptime
free -h
```

# 4. Fortgeschrittene Konzepte
## 4.1 Textverarbeitung
### Erweiterte sed-Beispiele
```bash
# Multiline mit sed
sed '/start/,/end/d' file.txt

# GNU vs BSD sed (macOS)
# GNU:
sed -i 's/old/new/g' file.txt
# BSD:
sed -i '' 's/old/new/g' file.txt
```

### Erweiterte awk-Beispiele
```bash
# Komplexe awk-Verarbeitung
awk '
BEGIN { sum = 0 }
$1 > 100 { sum += $1 }
END { print "Sum:", sum }
' data.txt
```

## 4.2 Prozess-Monitoring
```bash
# Prozesse überwachen
watch -n 1 'ps aux | sort -rk 3 | head -n 5'

# System-Logging
tail -f /var/log/syslog

# Ressourcenlimits
ulimit -a
```

## 4.3 Performance-Analyse
```bash
# CPU-Auslastung
top -bn1 | grep "Cpu(s)"

# Speicherverbrauch
free -m
vmstat 1

# I/O-Monitoring
iostat -x 1
```

# 5. Best Practices
## 5.1 Effiziente Shell-Nutzung
```bash
# History durchsuchen
history | grep command
ctrl-r  # Interaktive Suche

# Alias definieren
alias ll='ls -la'
alias gst='git status'
```

## 5.2 Debugging und Troubleshooting
```bash
# Debug-Modus aktivieren
set -x
bash -x script.sh

# Fehler abfangen
set -e
trap 'echo Error at line $LINENO' ERR
```

# Nützliche Einzeiler für den Workshop
```bash
# Alle Prozesse eines Users anzeigen
ps -u $USER

# Größte Dateien im aktuellen Verzeichnis
du -sh * | sort -hr | head -n 5

# Anzahl Dateien pro Verzeichnis
find . -type f -print0 | xargs -0 -n1 dirname | sort | uniq -c | sort -nr

# Speicherverbrauch pro Prozess
ps aux | awk '{print $6/1024 " MB\t\t" $11}' | sort -n
```
