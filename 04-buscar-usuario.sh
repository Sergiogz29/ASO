#!/usr/bin/env bash
#
# 04-buscar-usuario.sh — Buscar correo y teléfono de un usuario LDAP
#

read -p "Buscar por nombre o apellido: " TERM

ldapsearch -x -LLL \
  -b "ou=Usuarios,dc=tecnogar,dc=com" \
  "(&(objectClass=inetOrgPerson)(|(givenName=*${TERM}*)(sn=*${TERM}*)))" \
  uid cn mail telephoneNumber | sed '/^$/d'
