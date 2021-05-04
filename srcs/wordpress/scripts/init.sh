#! /bin/bash

i=0
while ! mariadb -h$MARIADB_HOST -P${MARIADB_PORT} -u$MARIADB_USER -p$MARIADB_PASSWORD; do
	if [ $i -ge 60 ]; then
		printf "Failed to connect to mariadb\n"
		exit 1
	fi
	printf "Trying to reach mariadb... ($i/60 sec)\n"
	i=$((i+1))
	sleep 1
done

printf "Connection to mariadb established.\n"

# ------ INSTALL WORDPRESS _IF_ REQUIRED ------#

if [ "$(mariadb -h${MARIADB_HOST} -P${MARIADB_PORT} -u$MARIADB_USER -p$MARIADB_PASSWORD -e "USE $MARIADB_DATABASE; SHOW TABLES;")" == "" ]; then
	wp config create --dbhost="$MARIADB_HOST" --dbname="$MARIADB_DATABASE" --dbuser="$MARIADB_USER" --dbpass="$MARIADB_PASSWORD"
	wp core install --url="$WP_URL:$WP_PORT" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER"	\
		--admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email
	# to work with redis and use it as a cache
	wp plugin install redis-cache --activate
	wp plugin update --all
	wp theme activate twentytwenty

	# populate wordpress website with some dummy content
	wp_users=("bob" "alice")
	# create each user and a related post
	userid=2
	for user in ${wp_users[@]}; do
		wp user create $user $user@example.com --role=author --user_pass=$user
		wp post create	--post_title="$user's post"	--post_content="Hello, my name is $user!"	\
						--post_status=publish --post_author=$userid
		userid=$((userid+1))
	done

	# test file which will be used by the wordpress action to ensure php-fpm works as expected.
	echo "<?php echo 'php-fpm works' ?>" > $PWD/test.php
fi

# redis-cache configuration, and enable it. 
cat /tmp/config/redis-config.php ./wp-config.php > .redis_setup_tmp
cat .redis_setup_tmp > wp-config.php
rm -rf .redis_setup_tmp

# Wait for redis to answer to the ping before trying to monitor it
i=1;
while [ "$(redis-cli -p ${REDIS_PORT} -h ${REDIS_HOST} ping 2> /dev/null)" != "PONG" ]; do
	if [ $i -ge 60 ]; then
		printf "redis-server took too much time to start properly!\n"
		exit 1
	fi
	printf "Waiting for redis-server to respond to ping... ($i/60 sec)\n"
	i=$(($i+1))
done
wp redis enable

# ----- PHP-FPM ----- #

# php-fpm is a PHP FastCGI implementation. nginx will use it to execute php
# scripts and return the code of the webpage generated on server side by
# the PHP code to the end user. This allows dynamic web page rendering.

sed -i "s/listen = 9000/listen = ${PHP_FPM_PORT}/g" /etc/php7/php-fpm.d/www.conf

printf "Starting php-fpm7...\n"
# ensure daemonization is done, even if it is supposed to be the default
php-fpm7 -F
