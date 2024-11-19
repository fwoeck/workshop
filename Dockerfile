FROM debian:12-slim

# Vermeiden von interaktiven Prompts während der Installation
ENV DEBIAN_FRONTEND=noninteractive

# System-Pakete installieren
RUN apt-get update && apt-get install -y \
    bash-completion \
    bc \
    curl \
    default-mysql-client \
    file \
    gawk \
    gcc \
    git \
    grep \
    htop \
    iputils-ping \
    less \
    make \
    man-db \
    nano \
    net-tools \
    openssh-client \
    procps \
    psmisc \
    rsync \
    sed \
    sysstat \
    tmux \
    tree \
    vim \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i 's/ENABLED="false"/ENABLED="true"/' /etc/default/sysstat \
    && service sysstat start

# Standard-Shell auf bash setzen
RUN chsh -s /bin/bash

# Workspace-Verzeichnis erstellen
RUN mkdir -p /workshop

# Basis-Konfiguration für SSH
RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh

# Bash-History-Größe erhöhen
RUN echo "HISTSIZE=10000" >> /root/.bashrc && \
    echo "HISTFILESIZE=20000" >> /root/.bashrc

# Nützliche Aliases hinzufügen
RUN echo "alias ll='ls -la'" >> /root/.bashrc && \
    echo "alias l='ls -l'" >> /root/.bashrc && \
    echo "alias h='history'" >> /root/.bashrc

# Arbeitsverzeichnis setzen
WORKDIR /workshop

# Container am Leben halten
CMD ["tail", "-f", "/dev/null"]
