#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ];then
    echo "[i] mysql_install_db"
    /usr/bin/mysql_install_db --user=root > /dev/null
fi

/usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf --user=root --character-set-server=utf8 &

if [ ! -d "/var/lib/mysql/mysql" ];then
    echo "[i] init mysql privilege"
    /usr/bin/mysql -uroot -e "source /tmp/privilege.sql;"
fi

php-fpm &

nginx -g "daemon off;" &

# rm -rf /tmp/*
