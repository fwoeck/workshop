**Lösungen**:

```bash
# Mit Einzelschritten
find . -name ".env" -type f -exec cp {} {}.bak \;
find . -name ".env" -type f -exec sed -i 's|DATABASE_URL=.*|DATABASE_URL="mysql://user:pass@localhost:3306/db"|' {} \;
find . -name ".env" -type f -exec sed -i 's/^REDIS_/#REDIS_/' {} \;

# Alternative mit einem Durchlauf
find . -name ".env" -type f -exec sh -c '
  cp "$1" "$1.bak" && 
  sed -i "s|DATABASE_URL=.*|DATABASE_URL=\"mysql://user:pass@localhost:3306/db\"|" "$1" &&
  sed -i "s/^REDIS_/#REDIS_/" "$1"
' sh {} \;
```
