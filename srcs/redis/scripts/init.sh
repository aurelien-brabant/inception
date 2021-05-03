#! /bin/sh

if redis-server /etc/myredis.conf --daemonize yes; then
	printf "[\033[1;32mOK\033[0m] redis-server started successfully!\n"
else
	printf "[\033[1;31mKO\033[0m] redis-server could not be started!\n"
fi

printf "redis monitoring started...\n"
redis-cli monitor
