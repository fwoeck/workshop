**Lösungen**:

```bash
# Registry starten
docker run -d \
  --name registry \
  -p 5000:5000 \
  -v registry-data:/var/lib/registry \
  registry:2

# Mit Authentifizierung
docker run -d \
  --name registry \
  -p 5000:5000 \
  -v registry-data:/var/lib/registry \
  -v auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd" \
  registry:2

# Image taggen und pushen
docker tag company/php-symfony:8.1 localhost:5000/company/php-symfony:8.1
docker push localhost:5000/company/php-symfony:8.1

# Registry durchsuchen
curl -X GET http://localhost:5000/v2/_catalog
curl -X GET http://localhost:5000/v2/company/php-symfony/tags/list

# Cleanup
docker rm -f registry
docker volume rm registry-data
```
