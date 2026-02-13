#!/bin/sh
#set -e

export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
export MYSQL_USER=$(cat /run/secrets/db_user)
export MYSQL_DATABASE=$(cat /run/secrets/db_name)

# Verificamos si el directorio de sistema 'mysql' ya existe
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database and user for the first time..."

    # 1. Inicializar directorio de datos
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    # 2. Iniciar temporalmente para configurar privilegios
    mariadbd --defaults-file=/etc/mariadb/mariadb-server.cnf --user=mysql &
    pid=$!

    # 3. Esperar a que el servidor responda antes de ejecutar SQL
    until mariadb-admin ping >/dev/null 2>&1; do
        echo "Waiting for MariaDB to start..."
        sleep 1
    done

    # 4. Configurar DB y Usuario
    mariadb -u root -h localhost <<EOF
	Create user if not exists '${MYSQL_USER}'@'%' IDENTIFIED BY  '${MYSQL_PASSWORD}';
	CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
	GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
	FLUSH PRIVILEGES;

EOF

    # 5. Apagar instancia temporal
    mariadb-admin -u root shutdown
    wait $pid
    echo "User creation complete."
else
    echo "Database already initialized, skipping setup..."
fi

# 6. Iniciar MariaDB de forma definitiva (en primer plano para el contenedor)
echo "Starting MariaDB..."
exec mariadbd --defaults-file=/etc/mariadb/mariadb-server.cnf --user=mysql

