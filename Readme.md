## 环境

- N: nginx
- P: PHP7
- M: MariaDB

## 引用

```
FROM docimg/npm:latest
......
```

## 构建
```bash
docker build -t docimg/app_npm:v1.0 .
docker stop app_npm && docker rm app_npm
docker run -d --name app_npm -p 80:80 docimg/app_npm:v1.0
```

## 配置文件

docker启动脚本：/start.sh

nginx配置文件：/etc/nginx/conf.d/www.conf
默认域名：phpinfo.cn

nginx日志：/var/log/nginx

php.ini：/usr/local/etc/php/php.ini

mysql数据：/var/lib/mysql

## start.sh

```bash
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
```
