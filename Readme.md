## 环境

- N: nginx
- P: PHP-7.4
- M: MariaDB

## 引用

```
FROM docimg/npm:latest
......
```

## 构建
```bash
docker push docimg/app_npm:v1.0

docker build -t docimg/app_npm:v1.0 .
docker stop app_npm && docker rm app_npm
docker run -d --name app_npm -p 80:80 docimg/app_npm:v1.0

MYSQL_DATABASE  # 启动时创建新的数据库
MYSQL_USER      # 新数据库的管理员账号
MYSQL_PASSWORD  # 新数据库的管理员密码
MYSQL_ROOT_PASSWORD # root用户密码，如果不提供系统将随机生成

docker exec -it app_npm /bin/sh
```

## 配置文件

docker启动脚本：/start.sh

nginx配置文件：/etc/nginx/conf.d/*.conf
php.ini：/usr/local/etc/php/php.ini

nginx日志：/var/log/nginx
mysql配置：/etc/mysql/my.cnf
mysql数据：/var/lib/mysql

web根目录：/var/www/html/

## 参考链接

- [mysql-docker](https://github.com/tonydeng/mysql-docker)
