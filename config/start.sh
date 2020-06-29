#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ];then
    mysql_install_db --user=root > /dev/null
fi

/usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf --user=root --character-set-server=utf8 &

if [ ! -d "/var/lib/mysql/mysql" ];then
    mysql -uroot -e "source /tmp/privilege.sql;"
fi

php-fpm &

nginx

# rm -rf /tmp/*
