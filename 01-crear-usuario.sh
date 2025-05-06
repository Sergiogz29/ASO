#!/usr/bin/env bash
#
# 01-crear-usuario.sh — Crear un nuevo usuario LDAP
#

BINDDN="cn=admin,dc=tecnogar,dc=com"
BINDPW="ProyectoLdap"
BASE="ou=Usuarios,dc=tecnogar,dc=com"

read -p "Nombre (givenName): " GIVEN
read -p "Apellido (sn):        " LAST
read -p "Usuario (uid):         " USUARIO
read -p "Correo (mail):         " MAIL
read -p "Teléfono (telephone):  " PHONE
read -s -p "Contraseña: " PASS; echo

PASS_HASH=$(slappasswd -s "$PASS")

LDIF=$(mktemp)
cat >"$LDIF" <<EOU
dn: uid=$USUARIO,$BASE
objectClass: top
objectClass: inetOrgPerson
cn: $GIVEN $LAST
sn: $LAST
givenName: $GIVEN
uid: $USUARIO
mail: $MAIL
telephoneNumber: $PHONE
userPassword: $PASS_HASH
EOU

ldapadd -x -D "$BINDDN" -w "$BINDPW" -f "$LDIF" && \
  echo "✔ Usuario $USUARIO creado." || echo "✘ Error creando $USUARIO."

rm -f "$LDIF"
