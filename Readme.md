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
docker push docimg/app_npm:v1.0

docker build -t docimg/app_npm:v1.0 .
docker stop app_npm && docker rm app_npm
docker run -d --name app_npm -p 80:80 docimg/app_npm:v1.0


docker exec -it app_npm /bin/sh
# MariaDB配置
mysql_secure_installation
```

## 配置文件

docker启动脚本：/start.sh

nginx配置文件：/etc/nginx/conf.d/www.conf
默认域名：phpinfo.cn

nginx日志：/var/log/nginx

php.ini：/usr/local/etc/php/php.ini

mysql数据：/var/lib/mysql

