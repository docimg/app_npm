#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ];then
    echo "[i] mysql_install_db"
    /usr/bin/mysql_install_db --user=root > /dev/null
    echo "[i] start mysql service"
    mysql_ready() {
        /usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf --user=root --character-set-server=utf8 &
    }
    while !(mysql_ready)
    do
        echo "waiting for mysql ..."
        sleep 3
    done
    echo "[i] init mysql privilege"
    /usr/bin/mysql -uroot -e "source /tmp/privilege.sql;"
else
    echo "[i] start mysql service"
    /usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf --user=root --character-set-server=utf8 &
fi

php-fpm &

nginx -g "daemon off;" &

rm -rf /tmp/*
