#!/usr/bin/env bash
#
# 02-modificar-usuario.sh — Modificar correo o teléfono de un usuario LDAP
#

BINDDN="cn=admin,dc=tecnogar,dc=com"
BINDPW="ProyectoLdap"
BASE="ou=Usuarios,dc=tecnogar,dc=com"

read -p "Usuario a modificar (uid): " USUARIO
echo "¿Qué atributo quieres cambiar?
 1) Correo
 2) Teléfono"
read -p "Opción (1/2): " OPCION

case "$OPCION" in
  1) ATTR="mail";           PROMPT="Nuevo correo";;
  2) ATTR="telephoneNumber"; PROMPT="Nuevo teléfono";;
  *) echo "Opción inválida"; exit 1;;
esac

read -p "$PROMPT: " NUEVO

LDIF=$(mktemp)
cat >"$LDIF" <<EOM
dn: uid=$USUARIO,$BASE
changetype: modify
replace: $ATTR
$ATTR: $NUEVO
EOM

ldapmodify -x -D "$BINDDN" -w "$BINDPW" -f "$LDIF" && \
  echo "✔ $ATTR actualizado para $USUARIO." || echo "✘ Error actualizando $USUARIO."

rm -f "$LDIF"
