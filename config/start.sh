#!/bin/sh

mysql_install_db --user=mysql --datadir=/var/lib/mysql

mysqld_safe &

mysqladmin -uroot password 'root'

mysql_ready() {
	mysqladmin ping --socket=/run/mysqld/mysqld.sock --user=root --password=root > /dev/null 2>&1
}

while !(mysql_ready)
do
	echo "waiting for mysql ..."
	sleep 3
done

php-fpm &

nginx &

tail -f /dev/null
