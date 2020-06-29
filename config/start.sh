#!/bin/sh

/usr/bin/mysqld --defaults-file=/etc/mysql/my.cnf --user=root --console --character-set-server=utf8 &

mysql -uroot -e "source /tmp/privilege.sql;"

php-fpm &

nginx &

rm -rf /tmp/*
