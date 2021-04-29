FROM	alpine:3.13.4

RUN 	apk -U upgrade && apk add nginx

COPY	./config/nginx.default.conf /etc/nginx/conf.d/default.conf

RUN		mkdir /run/nginx &&	\
		chown nginx:nginx /run/nginx

CMD		[ "nginx", "-g", "daemon off;" ]
