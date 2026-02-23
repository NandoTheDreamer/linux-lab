# Mapa del Sistema de Archivos Linux
## Directorios de Nivel Superior
### / ( Root )
- ** Proposito :** Directorio raiz del sistema
- ** Contenido :** Todos los demas directorios
- ** Permisos :** Solo root puede escribir directamente
### / home
- ** Proposito :** Directorios personales de usuarios
- ** Estructura :** ‘/ home / usuario1 ‘, ‘/ home / usuario2 ‘
- ** Permisos :** Cada usuario solo accede a su directorio
- ** Ejemplo :** ‘/ home / erwin / Documentos ‘
### / etc
- ** Proposito :** Archivos de configuracion del sistema
- ** Archivos importantes :**
- ‘/ etc / passwd ‘ - Informacion de usuarios
- ‘/ etc / group ‘ - Informacion de grupos
- ‘/ etc / hosts ‘ - Resolucion de nombres local
- ‘/ etc / ssh / sshd_config ‘ - Configuracion SSH
- ** Nota :** Requiere root para modificar
### / var
- ** Proposito :** Datos variables durante operacion
- ** Subdirectorios :**
- ‘/ var / log /‘ - Logs del sistema
- ‘/ var / www /‘ - Sitios web
- ‘/ var / cache /‘ - Cache de aplicaciones
- ‘/ var / spool /‘ - Colas de impresion
- ** Uso :** Crece con el tiempo
### / bin
- ** Proposito :** Binarios esenciales del sistema
- ** Contenido :** ‘ls ‘, ‘cp ‘, ‘mv ‘, ‘cat ‘, ‘bash ‘
- ** Disponible :** Para todos los usuarios
- ** Nota :** En sistemas modernos , symlink a ‘/ usr / bin ‘
### / usr
- ** Proposito :** Programas y datos de usuario
- ** Estructura :**
- ‘/ usr / bin /‘ - Binarios de usuario
- ‘/ usr / lib /‘ - Librerias compartidas
- ‘/ usr / local /‘ - Software instalado localmente
- ‘/ usr / share /‘ - Datos compartidos
### / opt
- ** Proposito :** Software opcional de terceros
- ** Ejemplo :** ‘/ opt / google / chrome ‘
- ** Uso :** Software que no sigue estandar FHS
### / tmp
- ** Proposito :** Archivos temporales
- ** Caracteristicas :** Se limpia en cada reinicio
- ** Permisos :** Cualquier usuario puede escribir
### / boot
- ** Proposito :** Archivos de arranque
- ** Contenido :** Kernel de Linux , GRUB
- ** Importante :** NO modificar sin conocimiento
### / dev
- ** Proposito :** Archivos de dispositivos
- ** Concepto :** " Todo es un archivo " en Linux
- ** Ejemplos :**
- ‘/ dev / sda ‘ - Primer disco duro
- ‘/ dev / null ‘ - Agujero negro ( descarta todo )
- ‘/ dev / random ‘ - Generador aleatorio
### / proc
- ** Proposito :** Sistema de archivos virtual
- ** Contenido :** Informacion de procesos y kernel
- ** Ejemplos :**
- ‘/ proc / cpuinfo ‘ - Info del CPU
- ‘/ proc / meminfo ‘ - Info de memoria
- ‘/ proc /1234/ ‘ - Info del proceso 1234
### / sys
- ** Proposito :** Interfaz moderna al kernel
- ** Contenido :** Informacion de hardware y drivers
## Comandos Utiles
‘‘‘ bash
# Ver estructura con tree
tree -L 1 /
# Tamano de directorios
du -sh /*
# Espacio en disco
df -h
# Explorar directorio
ls - lah / etc
‘‘‘