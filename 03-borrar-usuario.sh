#!/usr/bin/env bash
#
# 03-borrar-usuario.sh — Borrar usuario LDAP con confirmación
#

BINDDN="cn=admin,dc=tecnogar,dc=com"
BINDPW="ProyectoLdap"
BASE="ou=Usuarios,dc=tecnogar,dc=com"

read -p "Usuario a borrar (uid): " USUARIO
read -p "¿Seguro que deseas borrar '$USUARIO'? [y/N]: " CONF
CONF=${CONF,,}

if [[ "$CONF" != "y" ]]; then
  echo "Operación cancelada."; exit 0
fi

ldapdelete -x -D "$BINDDN" -w "$BINDPW" \
  "uid=$USUARIO,$BASE" && echo "✔ Usuario $USUARIO borrado." \
                       || echo "✘ Error borrando $USUARIO."
