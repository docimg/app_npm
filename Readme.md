## 环境

- N: nginx
- P: PHP-7.4
- M: MariaDB

## 构建
```bash
# 提交容器
docker push docimg/app_npm:v1.0

# 清空容器缓存
docker rmi docimg/app_npm:v1.0

# 构建&&运行
docker build -t docimg/app_npm:v1.0 .
docker stop app_npm
docker run -d --rm --name app_npm -p 80:80 -v /data/mysql:/var/lib/mysql docimg/app_npm:v1.0

# 进入容器内
docker exec -it app_npm /bin/sh
```

## 配置文件

- nginx配置文件：/etc/nginx/conf.d/localhost.conf
- nginx日志：/var/log/nginx/access.log  error.log

- php.ini：/usr/local/etc/php/php.ini

- mysql配置：/etc/mysql/my.cnf
- mysql数据：/var/lib/mysql/

- web根目录：/var/www/html/

```bash
# mysql root默认密码
drowssap

# mysql修改密码
SET password FOR 'root'@'localhost'=password('123456');

# 建库并指定用户和密码
CREATE DATABASE IF NOT EXISTS `visitor_record` CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL ON `visitor_record`.* to 'laravel'@'localhost' IDENTIFIED BY '123456789';
FLUSH PRIVILEGES;

# 支持composer
```


## 引用

```Dockerfile
FROM docimg/app_npm:latest

# /tmp/docker.sh会自动加入到CMD的末尾并执行
COPY _file/docker.sh /tmp/docker.sh
```

## 参考链接

- [mysql-docker](https://github.com/tonydeng/mysql-docker)
- [mysqld_safe](https://mariadb.com/kb/en/mysqld_safe/)
