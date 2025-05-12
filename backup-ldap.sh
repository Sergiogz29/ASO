#!/usr/bin/env bash
#
# backup-ldap.sh — copia diaria de LDAP con slapcat

BACKUP_DIR="/var/backups/ldap"
DATE=$(date +%F)
FILE="$BACKUP_DIR/ldap-$DATE.ldif"

# Asegúrate de que existe el directorio
mkdir -p "$BACKUP_DIR"
chown openldap:openldap "$BACKUP_DIR"
chmod 750 "$BACKUP_DIR"

# Volcado
/usr/sbin/slapcat -n 0 -l "$FILE" \
  && echo "$(date '+%F %T')  ✔ Backup created: $FILE" \
  || echo "$(date '+%F %T')  ✘ Backup failed" >&2

# (Opcional) elimina copias >7 días
find "$BACKUP_DIR" -type f -name 'ldap-*.ldif' -mtime +7 -delete
