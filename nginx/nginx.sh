#!/bin/bash

wget http://nginx.org/download/nginx-1.25.5.tar.gz
tar -xzf nginx-1.25.5.tar.gz
cd nginx-1.25.5
apt install gcc pcre pcre-devel zlib zlib-devel openssl openssl-devel -y

groupadd www
useradd -g www www

./configure \
--user=www \
--group=www \
--prefix=/usr/local/nginx \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_realip_module \
--with-threads \
--add-module=../ngx_http_proxy_connect_module