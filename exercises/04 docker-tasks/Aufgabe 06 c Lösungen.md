**Lösungen**:

```bash
# Dockerfile erstellen
cat > Dockerfile << 'EOF'
FROM php:8.1-fpm

# Essenzielle Erweiterungen
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install \
    pdo_mysql \
    zip

# Composer installieren
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Symfony CLI installieren
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

WORKDIR /var/www/html
EOF

# Image bauen
docker build -t company/php-symfony:8.1 .

# Mit Build-Args
docker build \
  --build-arg XDEBUG_MODE=debug \
  -t company/php-symfony:8.1-dev .

# Installation prüfen
docker run --rm company/php-symfony:8.1 php -m
```
