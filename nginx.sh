#!/bin/bash

cd /nginx
tar -xzf ngx_http_proxy_connect_module.tar.gz
tar -xzf nginx-1.25.5.tar.gz
cd nginx-1.25.5
apt install gcc libpcre3 libpcre3-dev zlib1g zlib1g-dev openssl libssl-dev make -y

groupadd www
useradd -g www www

patch -p1 < ../ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_102101.patch

./configure \
--user=www \
--group=www \
--prefix=/usr/local/nginx \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_realip_module \
--with-threads \
--add-module=../ngx_http_proxy_connect_module

make
make install

ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx

