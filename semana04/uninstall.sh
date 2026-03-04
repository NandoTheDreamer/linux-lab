#!/usr/bin/env bash
# uninstall.sh - Elimina los symlinks de los dotfiles
# Semana 4: Editores y dotfiles

set -e
echo "============================================="
echo "    Densinstalador de dotfiles - semana 4"
echo "============================================="
echo ""
desinstalar() {
	local destino="$HOME/.$1"
	if [ -L "$destino" ]; then
		rm "$destino"
		echo "[ELIMINADO] $destino"
	elif [ -f "$destino" ]; then
		echo "[IGNORADO] $destino (no es un symlink)"
	else
		echo "[NO EXISTE] $destino"
	fi
}

desisntalar bashrc
desinstalar bash_aliases
desinstalar vimrc

echo ""
echo "Desinstalacion completa."
echo "Si tienes backups en ~/.dotfiles-backup-*, puedes restaurarlos manualmente."
