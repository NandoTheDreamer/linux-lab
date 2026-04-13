# Semana 08: Comandos y Tecnicas Usadas

## mapfile
mapfile -t archivos < <(find "$REPO" -type f | sort)
Para que sirve: carga cada linea de la salida de find en un elemento del array 'archivos'. La opcion -t elimina el newline de cada elemento.

## Arrays asociativos
declare -A conteo
conteo["$ext"]=$(( ${conteo["$ext"]:-0} + 1 ))
Para que sirve: acumula el conteo de archivos por extension.
El patron:-0 inicializa la clave a 0 si no existia.

## Matriz con array indexado
matriz[$(( i * COLS + col ))]="$valor"
Para que sirve: simula una tabla bidimensional usando un array lineal. El indice se calcula como fila*columnas+columna.

## column
{ echo "ENCABEZADO1 ENCABEZADO2"; datos; } | column -t
Para que sirve: alinea automaticamente las columnas del texto sin calcular anchos manualmente.

## paste
paste -sd',' lista . txt
Para que sirve: convierte una columna en una sola linea separada por comas.



README MD
# Semana 08: Arrays y Matrices en Bash

## Objetivo
Analizar el repositorio linux-lab usando arrays indexados, arrays asociativos y matrices simuladas para generar un inventario completo de su contenido.

## Archivos
| Archivo             | Descripcion                            |
|---------------------|----------------------------------------|
| inventario.sh       | Script principal de analisis           |
| inventario-report.md| Reporte generado (no versionado)       |
| commands-used.md    | Documentacion de comandos y tecnicas   |

> inventario-report.md no se versiona (.gitignore)

## Uso
### Analizar el repositorio actual
	./inventario.sh

### Analizar otro directorio
	./inventario.sh /ruta/al/repo

## Tecnicas Aplicadas
- mapfile -t para cargar find en un array
- Arrays asociativos para conteo y tamano por extension
- Matriz 1D simulando tabla 2D por semana
- column -t para salida tabular alineada
- printf para formato de columnas fijas
- Reporte en Markdown generado automaticamente

## Checklist
- [x] Carga de archivos con mapfile
- [x] Conteo por extension con array asociativo
- [x] Calculo de tamano total por extension
- [x] Deteccion de README por semana
- [x] Matriz de resumen (scripts, docs, size)
- [x] Salida formateada con column y printf
- [x] Reporte Markdown generado
- [x] Desarrollo incremental con 8+ commits
