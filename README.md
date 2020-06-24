# Canvas Data Sync with MySQL
Este proyecto es una pequeña automatización para canvas-data-cli, permite sincronizar los datos, extraer los ficheros comprimidos y cargarlos en mysql con una sola linea de comandos.
Proximamente se añadirán transacciones de base de datos :)

# Pre-requisitos
-  Consola que permita la ejecución de bash (.sh)

	**Nota:** Si usted está en windows **la consola de git** es una excelente alternativa
	
- Tener instalado canvas data cli con sus respectivas dependencias

	**Guia:** https://community.canvaslms.com/docs/DOC-6600-how-to-use-the-canvas-data-cli-tool
	
	**Repo:** https://github.com/instructure/canvas-data-cli
- Tener instalado MySQL y crear una base de datos 

	**Nota:** Si usted está utilizando windows, instale XAMPP
	
- Cargar el script sql DDL en la base de datos creada

# Comenzando
Usted puede notar que la estructura del proyecto es identica a la estructura base de canvas-data-cli, esto se debe a que intentamos mantener la conversión original del proyecto y solo automatizar las tareas mediante los script bash.

Tal como si fuera a utilizar canvas-data-cli, asegurese de tener sus respectivas credenciales dentro del fichero config.js y mantenga el nombre de las carpetas para evitar conflictos.

Puede crear una carpeta en el escritorio de su equipo con el nombre "CanvasData" y dejar dentro todos los ficheros de este proyecto.

# Sobre los script

#### full.sh
Este script ejecutará la sincronización de los archivos descargados, luego descomprimirá todos los archivos que se descargaron y posteriormente los sincronizará con los datos de MySQL

#### uncompress.sh 
Este script solo descomprimirá todos los archivos descargados.

#### mysqlsync.sh
Este script solo subirá los ficheros descomprimidos a mysql.

# Ejecutar el script
Usted debe abrir la consola, dirigirse a la carpeta donde se encuentran los ficheros bash y ahí ejecutar el script que requiera.
Ejemplo:
    `sh full.sh -exec`
	
Dependiendo del script que esté ejecutando le pedirá alguna información, complete y espere que el script haga todo por usted :)

# MEJORA EL RENDIMIENTO
En ocasiones la importación puede tardar demaciado, sobretodo para la tabla request, por lo cual se han modificado las siguientes variables de entorno en MySQL para mejorar el rendimiento a la hora de importar. 

`
set unique_checks = 0;
set foreign_key_checks = 0;
set sql_log_bin=0;
`

Otra mejora importante que debes hacer manualmente es aumentar el `innodb_buffer_pool_size`, utilizando entre el 60% y 75% de tu memoria RAM, realiza esta configuración en el my.ini de MySQL.


# Mención :)
El script DDL de la base de datos de canvas ha sido una extración del proyecto "canvancement" de jamesjonesmath, solo lo he complementado con algunos indices extra para optimizar consultas.
Usted puede revisar su repositorio acá:
https://github.com/jamesjonesmath/canvancement/tree/master/canvas-data/mysql

