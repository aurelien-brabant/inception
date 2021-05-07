FROM		alpine:3.13.4

RUN 		apk -U upgrade && apk add	php7				\
										php7-fpm			\
										php7-phar			\
										php7-json			\
										php7-mysqli			\
										php7-curl			\
										php7-iconv			\
										php7-pecl-mailparse	\
										curl				\
										mariadb-client		\
										bash				\
										redis				# for redis-cli

# The wordpress installation directory

# install wp-cli
RUN			curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
			chmod +x wp-cli.phar &&	\
			cp wp-cli.phar /usr/bin/wp 

WORKDIR		/var/www/wordpress

# Configure wordpress installation. Done in a single ENV instruction to avoid
# excessive caching.

ENV				MARIADB_DATABASE="wordpress"			\
				MARIADB_USER="wordpress"				\
				MARIADB_PASSWORD="wordpress"			\
				MARIADB_HOST="mariadb"					\
				MARIADB_PORT=3306						\
												\
				WP_URL="http://localhost"				\
				WP_TITLE="wordpress website"			\
				WP_ADMIN_USER="admin"					\
				WP_ADMIN_PWD="admin"					\
				WP_ADMIN_EMAIL="example@example.com"	\
												\
				REDIS_HOST="redis"						\
				REDIS_PORT=6379

RUN				wp core download

# copy configuration files and setup needed files and folders

RUN				adduser -S nginx &&	\
				addgroup -S nginx

RUN				mkdir /var/log/php-fpm 
COPY			./config/php-fpm.conf /etc/php7/php-fpm.conf
COPY			./config/www.conf /etc/php7/php-fpm.d/www.conf

# Make the startup script available as /init.sh inside the container

COPY			./config /config
COPY			./config/wp-config.php ./
COPY			./scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT		[ "bash", "/entrypoint.sh" ]
