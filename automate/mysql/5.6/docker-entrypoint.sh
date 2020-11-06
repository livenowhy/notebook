#!/bin/bash
set -e

if [ ! -d '/var/lib/mysql/mysql' -a "${1%_safe}" = 'mysqld' ]; then
	if [ -z "$MYSQL_ROOT_PASSWORD" -a -z "$MYSQL_ALLOW_EMPTY_PASSWORD" ]; then
		echo >&2 'error: database is uninitialized and MYSQL_ROOT_PASSWORD not set'
		echo >&2 '  Did you forget to add -e MYSQL_ROOT_PASSWORD=... ? v2'
		exit 1
	fi
	
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	TEMP_FILE='/tmp/mysql-first-time.sql'

	# 以下允许 root 外网登陆
	cat > "$TEMP_FILE" <<-EOSQL
		DELETE FROM mysql.user ;
		CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
		GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
		DROP DATABASE IF EXISTS test ;
	EOSQL

	# 以下用于创建 初始化的数据库及链接数据库的用户名和密码
	if [ "$MYSQL_DATABASE" ]; then
		echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;" >> "$TEMP_FILE"
	fi
	
	if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
		echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> "$TEMP_FILE"
		
		if [ "$MYSQL_DATABASE" ]; then
			echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' ;" >> "$TEMP_FILE"
		fi
	fi
	
	echo 'FLUSH PRIVILEGES ;' >> "$TEMP_FILE"
	cat /tmp/r.sql >> "$TEMP_FILE"
	
	set -- "$@" --init-file="$TEMP_FILE"
fi

chown -R mysql:mysql /var/lib/mysql
echo "$@"
exec "$@"
