# Ejemplos Practicos de Navegacion
## Explorar el Sistema
‘‘‘ bash
# Ver ubicacion actual
pwd
# Ir al directorio raiz
cd /
# Listar contenido
ls -l
# Ver arbol de 2 niveles
tree -L 2 -d
# Volver a HOME
cd ~
‘‘‘
## Examinar Directorios
‘‘‘ bash
# Ver configuraciones
ls -lh / etc | head -20
# Ver logs del sistema
ls -lh / var / log
# Ver tu directorio personal
ls -la ~
# Explorar dispositivos
ls -l / dev | head
‘‘‘
## Informacion del Sistema
‘‘‘ bash
# Info del kernel
uname -a
# Distribucion
cat / etc /os - release
# CPU
cat / proc / cpuinfo | grep " model name " | head -1
# Memoria
cat / proc / meminfo | head -5
free -h
# Discos
lsblk
df -h
# Tamano de directorios raiz
du -sh /* 2 >/ dev / null
‘‘‘
## Navegacion Avanzada
‘‘‘ bash
# Ir a directorio y volver
cd / var / log
cd -
# Crear y entrar a directorio
mkdir -p ~/ proyectos / linux
cd ~/ proyectos / linux
# Ver historial de directorios
dirs -v
‘‘‘
## Buscar Archivos
‘‘‘ bash
# Buscar archivo por nombre
find / etc - name " hosts " 2 >/ dev / null
# Buscar archivos . conf
find / etc - name "*. conf " - type f 2 >/ dev / null | head
# Archivos grandes en home
find ~ - type f - size +10 M 2 >/ dev / null
‘‘‘