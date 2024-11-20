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
├── exercises
│   ├── 01 gnu-commands-tasks
│   ├── 02 git-tasks
│   ├── 03 ssh-tasks
│   └── 04 docker-tasks
└── notes
    ├── 01 gnu-commands-tasks.md
    ├── 02 git-tasks.md
    ├── 03 ssh-tasks.md
    └── 04 docker-tasks.md
```

## Verwendung

0. Repo clonen:
```bash
git clone https://github.com/fwoeck/workshop.git
cd workshop
```

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
