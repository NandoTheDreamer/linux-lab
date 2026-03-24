#!/bin/bash

#backup-check.sh - Validador de backups
#Uso: ./backup-check.sh [directorio_backup]
#
#Verifica existencia, antigüedad y tamaño de backups.
#Genera un log con el resultado de cada verificación.

#===Constantes configurables===
readonly VERSION="1.0.0"
readonly DIR_BACKUP="${1:-/backup}"
readonly DIR_LOGS="$(dirname "$0")/logs"
readonly LOGFILE="$DIR_LOGS/backup-check-$(date +%Y%m%d).log"
readonly MAX_HORAS_SIN_BACKUP=24	#alertar si el backup es más viejo
readonly MIN_TAMANIO_MB=10		#alertar si el backup es más pequeño
readonly MAX_TAMANIO_MB=50000		#alertar si el backup es muy grande

#===Variables de estado global===
estado_global="OK"

#===Función de uso===
uso() {
	echo "Uso: $0 [directorio_backup]"
	echo ""
	echo "	directorio_backup	Directorio a verificar"
	echo "				(por defecto: /backup)"
	echo ""
	echo "Opciones:"
	echo "	--version	Versión del script"
	echo "	--help		Esta ayuda"
	echo ""
	echo "Ejemplos:"
	echo "	$0"
	echo "	$0 /mnt/respaldo"
	echo "	$0 ~/backup-prueba"
	exit 2
}

#===Función de logging===
#Uso: log NIVEL "mensaje"
log() {
	local nivel="$1"
	local mensaje="$2"
	local timestamp
	timestamp=$(date '+%Y-%m-%d %H:%M:%S')
	printf "[%s] [%-7s] %s\n" "$timestamp" "$nivel" "$mensaje" \ | tee -a "$LOGFILE"

	#Actualizar el estado global si el nivel es grave
	if [ "$nivel" = "ERROR" ] && [ "$estado_global" != "ERROR" ]; then
		estado_global="ERROR"
	elif [ "$nivel" = "WARNING" ] && [ "$estado_global" = "OK" ]; then
		estado_global="WARNING"
	fi
}

#===Procesar argumentos especiales===
case "${1:-}" in
	--version) echo "backup-check.sh v$VERSION"; exit 0 ;;
	--help|-h) uso ;;
esac

#===Verificación 1: existencia del directorio===
verificar_directorio() {
	log "INFO" "Verificando directorio: $DIR_BACKUP"
	if [ ! -e "$DIR_BACKUP" ]; then
		log "ERROR" "El directorio '$DIR_BACKUP' no existe."
		return 1
	fi
	if [ ! -d "$DIR_BACKUP" ]; then
		log "ERROR" "'$DIR_BACKUP' existe pero no es un directorio."
		return 1
	fi
	if [ ! -r "$DIR_BACKUP" ]; then
		log "ERROR" "Sin permiso de lectura en '$DIR_BACKUP'."
		return 1
	fi
	log "OK" "Directorio accesible: $DIR_BACKUP"
	return 0
}

#=== Verificación 2: existencia de archivos de backup ===
verificar_archivos() {
	log "INFO" "Buscando archivos de backup (*. tar . gz )..."
	local total
	total=$(find "$DIR_BACKUP" -maxdepth 1 -type f \ - name "*.tar.gz" | wc -l )
	if [ "$total" -eq 0 ]; then
		log "ERROR" "No se encontraron archivos .tar.gz en $DIR_BACKUP"
		return 1
	fi
	log "OK" "Se encontraron $total archivo(s) de backup."
	#Verificar que el más reciente no está vacío
	local ultimo
	ultimo=$(find "$DIR_BACKUP" -maxdepth 1 -type f \ -name "*.tar.gz" | sort | tail -1)
	if [ ! -s "$ultimo" ]; then
		log "WARNING" "El archivo más reciente está vacío: $ultimo"
		return 0
	fi
	log "OK" "Último backup: $(basename "$ultimo ")"
	return 0
}


# === Verificación 3: antigüedad del último backup ===
verificar_antigüedad() {
	log "INFO" "Verificando antigüedad del backup más reciente..."
	# Contar archivos modificados en las últimas MAX_HORAS horas
	# find -mtime -1 equivale a " modificado hace menos de 24 horas"
	local dias_limite=$(( MAX_HORAS_SIN_BACKUP / 24 )) [ "$dias_limite" - eq 0 ] && dias_limite=1
	
	local recientes
	recientes=$(find "$DIR_BACKUP" -maxdepth 1 -type f \ -name "*.tar.gz" -mtime -"$dias_limite" | wc -l)
	if [ "$recientes" -eq 0 ]; then
		log "WARNING" \ " No hay backups de las últimas ${MAX_HORAS_SIN_BACKUP}h."
		return 0
	fi
	log "OK" "$recientes backup(s) recientes (últimas ${MAX_HORAS_SIN_BACKUP}h)."
	return 0
}


#===Verificación 4: tamaño del directorio de backups ===
verificar_tamanio() {
	log "INFO" "Verificando tamaño del directorio de backups..."
	local tamanio_mb
	tamanio_mb=$(du -sm "$DIR_BACKUP" | awk '{print $1}')
	log "INFO" "Tamaño total: ${tamanio_mb} MB"
	if [ "$tamanio_mb" -lt "$MIN_TAMANIO_MB" ]; then
		log "WARNING" \ "Directorio pequeño: ${tamanio_mb} MB (mínimo: ${MIN_TAMANIO_MB} MB)"
		return 0
	fi
	if [ "$tamanio_mb" -gt "$MAX_TAMANIO_MB" ]; then
		log "WARNING" \ "Directorio grande: ${tamanio_mb} MB (máximo: ${MAX_TAMANIO_MB} MB)"
		return 0
	fi
	log "OK" "Tamaño dentro del rango: ${tamanio_mb} MB"
	return 0
}


#===Inicio del reporte===
log "INFO" "=== backup-check.sh v$VERSION - Inicio ==="
log "INFO" "Directorio objetivo: $DIR_BACKUP"

# Ejecutar verificaciones en orden.
# Si el directorio no existe, no tiene sentido continuar.
if ! verificar_directorio; then
	log "ERROR" "Verificación abortada: directorio inaccesible."
	exit 1
fi

verificar_archivos
verificar_antigüedad
verificar_tamanio

#=== Estado final ===
log "INFO" "=== Verificación completada ==="
case "$estado_global" in
	OK)
		log "OK"	"RESULTADO: todos los checks pasaron correctamente."
		exit 0
		;;
	WARNING)
		log "WARNING" "RESULTADO: verificación completada con advertencias."
		exit 0
		;;
	ERROR)
		log "ERROR" "RESULTADO: se detectaron errores que requieren atención."
		exit 1
		;;
esac
