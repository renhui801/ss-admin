FROM centos

RUN useradd -M -s /sbin/nologin www

ADD nginx-1.8.1.tar.gz /usr/local/src

RUN yum install libxslt-devel -y gd gd-devel GeoIP GeoIP-devel pcre pcre-devel

RUN yum -y install gcc gcc-c++

RUN yum -y install openssl openssl-devel

WORKDIR /usr/local/src/nginx-1.8.1

RUN ./configure --user=www --group=www --prefix=/usr/local/nginx --with-file-aio --with-ipv6 --with-http_ssl_module  --with-http_spdy_module --with-http_realip_module    --with-http_addition_module    --with-http_xslt_module   --with-http_image_filter_module    --with-http_geoip_module  --with-http_sub_module  --with-http_dav_module --with-http_flv_module    --with-http_mp4_module --with-http_gunzip_module  --with-http_gzip_static_module  --with-http_auth_request_module  --with-http_random_index_module   --with-http_secure_link_module   --with-http_degradation_module   --with-http_stub_status_module && make && make install

EXPOSE 80

ADD libmcrypt-2.5.8.tar.gz /usr/local/src

WORKDIR /usr/local/src/libmcrypt-2.5.8

RUN ./configure && make && make install

ADD php-7.1.27.tar.gz /usr/local/src

RUN yum -y install libxml2 libxml2-devel bzip2 bzip2-devel libjpeg-turbo libjpeg-turbo-devel libpng libpng-devel freetype freetype-devel zlib zlib-devel libcurl libcurl-devel

WORKDIR /usr/local/src/php-7.1.27

RUN ./configure --prefix=/usr/local/php --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-mysql=mysqlnd --with-openssl --enable-mbstring --with-freetype-dir --with-jpeg-dir --with-png-dir --with-mcrypt --with-zlib --with-libxml-dir=/usr --enable-xml  --enable-sockets --enable-fpm --with-config-file-path=/usr/local/php/etc --with-bz2 --with-gd && make && make install

ADD nginx.conf /usr/local/nginx/conf/nginx.conf

ADD ss.tar /usr/local/nginx/html

RUN chmod 777 -R /usr/local/nginx/html/ss.winhui.top/storage

RUN cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf

RUN sed -i -e 's@;pid = run/php-fpm.pid@pid = run/php-fpm.pid@g' -e 's@nobody@php@g' -e 's@listen = 127.0.0.1:9000@listen = 0.0.0.0:9000@g' /usr/local/php/etc/php-fpm.conf

RUN cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf

RUN cp /usr/local/src/php-7.1.27/php.ini-production /usr/local/php/etc/php.ini

ADD www.conf /usr/local/nginx/conf/www.conf

ENV MYSQL_HOST mysql

ENV MYSQL_PORT 3306

ENV MYSQL_USER root

ENV MYSQL_PASS root

ENV MYSQL_DB sspanel

ADD env.sh /tmp/env.sh

ADD config.php /usr/local/nginx/html/ss.winhui.top/config/.config.php

RUN chmod +x /tmp/env.sh

RUN rm /usr/local/src/*.tar.gz -rf

CMD /bin/sh -c '/tmp/env.sh && /usr/local/php/sbin/php-fpm -y /usr/local/php/etc/php-fpm.conf && /usr/local/nginx/sbin/nginx -g "daemon off;"'
