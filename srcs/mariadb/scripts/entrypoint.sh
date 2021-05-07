#! /bin/bash

# This script is executed as the mysql user and _MUST_ be SOURCED
# The configuration files are found in ../config

sed -i "s/port = 3306/port = ${MARIADB_PORT}/g" /etc/my.cnf.d/mariadb-server.cnf

mariadbd &

if ! mysqladmin --wait=30 ping; then
	printf "Could not ping mariadb for 30 seconds, runtime configuration is not possible.\n"
	exit 1
fi

# Exit gracefully if config has already been done.

# Apply the required runtime configuration, such as disabling root access and creating specified user and database.
# This eval syntax is required to properly expand environment variables, but is clearly dangerous. The runtime_config.sql
# must only contain SQL code, which can additonally make use of environment variables.
cat /tmp/.runtime_config_done 2> /dev/null
if [ $? -ne 0 ]; then
	mariadb -e "$(eval "echo \"$(cat ../config/runtime_config.sql)\"")"
	printf "\033[0;32mRuntime configuration has been applied.\033[0m\n"
	touch /tmp/.runtime_config_done
fi

pkill mariadbd
mariadbd
