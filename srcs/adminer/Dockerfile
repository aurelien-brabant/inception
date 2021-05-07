FROM		alpine:3.13.4

RUN 		apk -U upgrade && apk add	php7			\
										php7-session	\
										php7-fpm		\
										php7-mysqli		\
										wget			\
										nginx

RUN			wget -O /tmp/adminer.php https://github.com/vrana/adminer/releases/download/v4.8.0/adminer-4.8.0-mysql.php	&&	\
			mkdir -p /var/www/adminer &&	\
			mv /tmp/adminer.php /var/www/adminer/index.php

# php-fpm setup

COPY		./config/php-fpm.conf /etc/php7/php-fpm.conf
COPY		./config/www.conf /etc/php7/php-fpm.d/www.conf
RUN			mkdir -p /var/log/php-fpm

# nginx setup

RUN			mkdir -p /run/nginx && chown -R nginx:nginx /run/nginx
COPY		./config/nginx.default.conf /etc/nginx/http.d/default.conf

COPY		./scripts/entrypoint.sh .

ENTRYPOINT			[ "sh", "entrypoint.sh" ]
