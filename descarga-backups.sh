#!/usr/bin/env bash
SERVER="ubuntu@3.234.169.194"
KEYFILE="$HOME/.ssh/aws-academy.pem"
REMOTE_DIR="/var/backups/ldap"
LOCAL_DIR="$HOME/ldap-backups"

mkdir -p "$LOCAL_DIR"

# Listar ficheros en servidor y descargarlos
ssh -i "$KEYFILE" -o StrictHostKeyChecking=no "$SERVER" \
  "find '$REMOTE_DIR' -maxdepth 1 -type f -name 'ldap-*.ldif' -mtime -7 -print0" \
    | xargs -0 -I {} scp -i "$KEYFILE" "$SERVER":"{}" "$LOCAL_DIR/"

echo "Copias descargadas en $LOCAL_DIR"
