#!/usr/bin/env bash
# install.sh - Instala los dotfiles en ~/
# Semana 4: Editores y Dotfiles

set -e

#Directorio donde estara este script
DOTFILES_DIR="$(cd "$(dirname "$0")/dotfiles" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d)"

echo "============================================"
echo "    Instalador de Dotfiles -Semana 4"
echo "============================================"
echo "Dotfiles en: $DOTFILES_DIR"
echo ""

# Funcion para instalar un dotfile
instalar() {
	local fuente="$DOTFILES_DIR/$1"
	local destino="$HOME/.$1"

	if [ ! -f "$fuente" ]; then
		echo "[ERROR] No encontrado: $fuente"
		return 1
	fi

	if [ -f "$destino" ] && [ ! -L "$destino" ]; then
		mkdir -p "$BACKUP_DIR"
		cp "$destino" "$BACKUP_DIR/"
		echo "[BACKUP] $destino     $BACKUP_DIR/"
	fi

	rm  -f "$destino"

	ln -s "$fuente" "$destino"
	echo "[OK] $destino     $fuente"
}

instalar bashrc
instalar bash_aliases
instalar vimrc

echo ""
echo "Instalacion completa."
echo "Para aplicar los cambios ahora, ejecuta:"
echo "  source ~/.bashrc"
