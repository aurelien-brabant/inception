#! /bin/sh

sed -i "s/SERVER_NAME_TEMPLATE/${DOMAIN_NAME}/g" /etc/nginx/http.d/default.conf
sed -i "s/LISTEN_TEMPLATE/${ADMINER_PORT}/g" /etc/nginx/http.d/default.conf

php-fpm7
nginx -g "daemon off;"
