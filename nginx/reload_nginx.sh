#!/bin/sh

cat /etc/nginx/conf.d/*.conf
nginx -s reload -g 'pid /tmp/nginx.pid;' 
