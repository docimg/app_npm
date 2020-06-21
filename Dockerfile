FROM php:7.4-fpm-alpine

LABEL Organization="docimg" Author="hdxw <909712710@qq.com>"
LABEL maintainer="909712710@qq.com"

COPY src /var/www/html
COPY config/start.sh /start.sh

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk add --update --no-cache tar curl nginx mysql mysql-client \
    && apk add --update php7-fpm php7  php7-dev  php7-apcu  php7-bcmath  php7-xmlwriter  php7-ctype \
        php7-curl  php7-exif  php7-iconv  php7-intl  php7-json  php7-mbstring php7-opcache  php7-openssl \
        php7-pcntl  php7-pdo  php7-mysqlnd  php7-mysqli  php7-pdo_mysql  php7-pdo_pgsql  php7-phar \
        php7-posix  php7-session  php7-xml  php7-simplexml  php7-mcrypt  php7-xsl  php7-zip  php7-zlib \
        php7-dom  php7-redis php7-tokenizer  php7-gd  php7-fileinfo  php7-zmq  php7-memcached  php7-xmlreader \
    && curl -sS https://getcomposer.org/installer | php --install-dir=/usr/bin/ --filename=composer

WORKDIR /var/www/html

EXPOSE 80

VOLUME ["/var/log/nginx"]

CMD /start.sh
