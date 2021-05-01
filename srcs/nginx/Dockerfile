FROM	alpine:3.13.4

RUN 	apk -U upgrade && apk add	nginx	\
									openssl

COPY	./config/nginx.default.conf /etc/nginx/conf.d/default.conf

RUN		mkdir /run/nginx &&	\
		chown nginx:nginx /run/nginx

ENV		CERTS_DIR=/etc/openssl	\
		DOMAIN_NAME=localhost	\
		PHP_FPM_HOST=php-fpm	\
		PHP_FPM_PORT=9000		\
		TLS_VERSION=1.3

COPY	./scripts /tmp/scripts
RUN		chmod -R +x /tmp/scripts
WORKDIR	/tmp/scripts

CMD		[ "./init.sh" ]
