#! /bin/sh

# Set redis listening port 
sed -i "s/port 6379/port ${REDIS_PORT}/g" /etc/myredis.conf

if redis-server /etc/myredis.conf --daemonize yes; then
	printf "[\033[1;32mOK\033[0m] redis-server daemon started successfully!\n"
else
	printf "[\033[1;31mKO\033[0m] redis-server could not be started!\n"
fi

# Wait for redis to answer to the ping before trying to monitor it
i=1;
while [ "$(redis-cli -p ${REDIS_PORT} ping 2> /dev/null)" != "PONG" ]; do
	if [ $i -ge 60 ]; then
		printf "redis-server took too much time to start properly!\n"
		exit 1
	fi
	printf "Waiting for redis-server to respond to ping... ($i/60 sec)\n"
	i=$(($i+1))
done

printf "redis monitoring started...\n"
redis-cli -p ${REDIS_PORT} monitor
