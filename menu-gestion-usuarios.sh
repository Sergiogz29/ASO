#!/usr/bin/env bash
#
# menu-gestion-usuarios.sh — Menú de gestión de usuarios LDAP usando select
#

# Directorio donde están los scripts
SCRIPTDIR="$(cd "$(dirname "$0")" && pwd)"

# Prompt para select
PS3='Elige una opción [1-5]: '

# Opciones del menú
options=(
  "Crear usuario"
  "Modificar datos de usuario"
  "Borrar usuario"
  "Buscar usuario"
  "Salir"
)

while true; do
  clear
  echo "Gestión de Usuarios LDAP - Tecnogar SL"
  echo "======================================="
  # Muestra el menú numerado
  select opt in "${options[@]}"; do
    case $REPLY in
      1) "$SCRIPTDIR/01-crear-usuario.sh"; break ;;
      2) "$SCRIPTDIR/02-modificar-usuario.sh"; break ;;
      3) "$SCRIPTDIR/03-borrar-usuario.sh"; break ;;
      4) "$SCRIPTDIR/04-buscar-usuario.sh"; break ;;
      5) echo "¡Adiós!"; exit 0 ;;
      *) echo "Opción inválida";;
    esac
  done
  echo
  read -n1 -r -p "Pulsa una tecla para volver al menú…" _
done

