# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: abrabant <abrabant@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/13 23:04:39 by abrabant          #+#    #+#              #
#    Updated: 2021/05/07 17:11:02 by abrabant         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM		alpine:3.13.4

RUN			apk -U upgrade && apk add mariadb mariadb-client bash

RUN			mkdir -p /run/mysqld && mkdir -p /var/lib/mysql
RUN			chown -R mysql:mysql /run/mysqld && chown mysql:mysql /var/lib/mysql
RUN			mariadb-install-db --user=mysql --datadir='/var/lib/mysql'

ENV			MARIADB_USER=mariadb_user			\
			MARIADB_PASSWORD=mariadb_password	\
			MARIADB_DATABASE=mariadb_database	\
			MARIADB_PORT=3306

COPY  		./config/mariadb-server.cnf  /etc/my.cnf.d/mariadb-server.cnf
RUN			chown -R mysql:mysql /etc/my.cnf.d

COPY		./scripts /tmp/scripts
COPY		./config/runtime_config.sql /tmp/config/runtime_config.sql
RUN			chown -R mysql:mysql /tmp/config &&	\
			chown -R mysql:mysql /tmp/scripts 

WORKDIR		/tmp/scripts

USER		mysql

ENTRYPOINT	[ "sh", "entrypoint.sh" ]
