FROM		alpine:3.13.4

RUN 		apk -U upgrade && apk add redis

ENV			REDIS_PORT=6379

# Do not override default config, create a myredis.conf instead.
COPY		./config/redis.conf /etc/myredis.conf

COPY		./scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT	[ "sh", "entrypoint.sh" ]
