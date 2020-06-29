#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ];then
    mysql_install_db --defaults-file=/etc/mysql/my.cnf --user=root > /dev/null
fi

/usr/bin/mysqld --defaults-file=/etc/mysql/my.cnf --user=root --console --character-set-server=utf8 &

if [ ! -d "/var/lib/mysql/mysql" ];then
    mysql -uroot -e "source /tmp/privilege.sql;"
fi

php-fpm &

nginx &

rm -rf /tmp/*
