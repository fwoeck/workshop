# Shell-Workshop Setup

## Verzeichnisstruktur

```
workshop/
├── Dockerfile
├── README.md
├── config
│   ├── bashrc
│   └── ssh
├── docker-compose.yml
└── exercises
    ├── 01 gnu-commands-tasks
    ├── 02 git-tasks
    ├── 03 ssh-tasks
    └── 04 docker-tasks
```

## Verwendung

1. Environment starten:
```bash
docker-compose up -d
```

2. In den Container einsteigen:
```bash
docker-compose exec workshop bash
```

3. Umgebung stoppen:
```bash
docker-compose down
```

## Hinweise
- Der Container enthält alle benötigten Tools für die Workshop-Aufgaben
- Das `/workshop`-Verzeichnis ist der Hauptarbeitsbereich
- SSH-Konfiguration ist vorbereitet für die SSH-Aufgaben
- Bash-History und Home-Verzeichnis sind persistent
- Die Umgebung ist minimal aber vollständig für die Aufgaben
- Alle Standard-GNU-Tools sind verfügbar

## Zusätzliche Konfigurationsmöglichkeiten
- Weitere Volumes für spezifische Aufgaben
- Zusätzliche Port-Mappings nach Bedarf
- Anpassung der Ressourcen-Limits
- Integration weiterer Tools über das Dockerfile
