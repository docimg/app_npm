#!/bin/sh

if [ -d /etc/mysql/root_password ]; then
    echo "[i] MySQL directory already present, skipping creation"
    /usr/bin/mysqld --defaults-file=/etc/mysql/my.cnf --user=root --console --character-set-server=utf8 
else
    echo "[i] MySQL data directory not found, creating initial DBs"

    mkdir -p /var/lib/mysql

    mysql_install_db --user=root > /dev/null

    if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
        MYSQL_ROOT_PASSWORD=`pwgen 16 1`
        echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
        echo $MYSQL_ROOT_PASSWORD > /etc/mysql/root_password
    fi

    MYSQL_DATABASE=${MYSQL_DATABASE:-""}
    MYSQL_USER=${MYSQL_USER:-""}
    MYSQL_PASS=${MYSQL_PASS:-""}

    tfile=`mktemp`
    if [ ! -f "$tfile" ]; then
        return 1
    fi

    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("") WHERE user='root' AND host='localhost';
EOF

    if [ "$MYSQL_DATABASE" != "" ]; then
        echo "[i] Creating database: $MYSQL_DATABASE"
        echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

        if [ "$MYSQL_USER" != "" ]; then
            echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASS"
            echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS';" >> $tfile
        fi
    fi

    /usr/bin/mysqld --defaults-file=/etc/mysql/my.cnf --user=root --console --character-set-server=utf8 &

    mysql -uroot -e "source $tfile;"

    rm -f $tfile
fi

unset MYSQL_DATABASE
unset MYSQL_USER
unset MYSQL_PASS
unset MYSQL_ROOT_PASSWORD

php-fpm &

nginx &

tail -f /dev/null
