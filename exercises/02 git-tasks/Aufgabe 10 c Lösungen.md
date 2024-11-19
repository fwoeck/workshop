**Lösungen**:

```bash
# Manuelle Bisect-Session
git bisect start
git bisect bad HEAD
git bisect good v1.0.0
# Für jeden Commit manuell testen
git bisect good/bad
git bisect reset

# Mit Test-Script
git bisect start
git bisect bad HEAD
git bisect good v1.0.0
git bisect run ./test-script.sh

# Mit komplexem Test
cat > test-script.sh << 'EOF'
#!/bin/bash

./faulty_code.sh
exit $?
EOF
chmod +x test-script.sh
git bisect run ./test-script.sh

# Mit Logging
git bisect start > bisect-log.txt
git bisect bad HEAD >> bisect-log.txt
git bisect good v1.0.0 >> bisect-log.txt
git bisect run ./test-script.sh >> bisect-log.txt
git bisect reset
```
