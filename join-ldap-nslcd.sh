#!/usr/bin/env bash
# join-ldap-nslcd.sh – Automatiza unión al LDAP de Tecnogar

set -e
if [ "$#" -ne 4 ]; then
  echo "Uso: $0 <LDAP_URI> <BASE_DN> <BIND_DN> <BIND_PWD>"
  exit 1
fi

LDAP_URI="$1"
BASE_DN="$2"
BIND_DN="$3"
BIND_PWD="$4"

echo "=== Instalando paquetes ==="
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libnss-ldapd nslcd ldap-utils nscd libpam-ldapd

echo "=== Configurando /etc/nslcd.conf ==="
cat > /etc/nslcd.conf <<EOF
uri $LDAP_URI
base $BASE_DN
binddn $BIND_DN
bindpw $BIND_PWD
ldap_version 3
ssl off
EOF

echo "=== Ajustando nsswitch.conf ==="
sed -i 's/^passwd:.*$/passwd:  files ldap/'  /etc/nsswitch.conf
sed -i 's/^group:.*$/group:   files ldap/'  /etc/nsswitch.conf
sed -i 's/^shadow:.*$/shadow:  files ldap/' /etc/nsswitch.conf

echo "=== Reiniciando servicios ==="
systemctl restart nslcd nscd

echo "=== Habilitando PAM y home dirs ==="
pam-auth-update --enable ldap-auth --enable unix-auth --enable mkhomedir --package

echo "¡Listo! Verifica con:"
echo "  getent passwd juanp"
echo "  su - juanp"
