FROM		alpine:3.13.4

RUN 		apk -U upgrade && apk add redis

# Do not override default config, create a myredis.conf instead.
COPY		./config/redis.conf /etc/myredis.conf
COPY		./scripts /tmp/scripts

WORKDIR		/tmp/scripts
RUN			chmod -R +x /tmp/scripts

CMD			[ "./init.sh" ]
