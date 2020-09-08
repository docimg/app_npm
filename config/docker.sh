#!/bin/sh

if [ -f "/tmp/start.sh" ];then
  source /tmp/start.sh
fi

if [ ! -d "/var/lib/mysql/mysql" ];then
    echo "[i] mysql_install_db"
    mysql_install_db --user=root > /dev/null

    echo "[i] start mysql service"
    mysqld_safe --defaults-file=/etc/mysql/my.cnf --user=root --character-set-server=utf8 &
    mysql_ready() {
        mysqladmin ping --socket=/etc/mysql/mysql.sock --user=root > /dev/null 2>&1
    }
    while !(mysql_ready)
    do
        echo "[i] waiting for mysql ..."
        sleep 3
    done
    
    echo "[i] init mysql privilege"
    mysql -uroot -e "source /tmp/privilege.sql;"
else
    echo "[i] start mysql service"
    mysqld_safe --defaults-file=/etc/mysql/my.cnf --user=root --character-set-server=utf8 &
fi

php-fpm &

nginx -g "daemon off;" &

if [ -f "/tmp/stop.sh" ];then
  source /tmp/stop.sh
fi

rm -rf /tmp/*
