#!make
include srcs/.env
#export $(shell sed 's/=.*//' envfile)

RM=rm -rf
COMPOSE=docker-compose -f srcs/docker-compose.yaml

all: build $(WORDPRESS_HOST_VOLUME_PATH) $(MARIADB_HOST_VOLUME_PATH) up

build:
	$(COMPOSE) build	

up:
	$(COMPOSE) up

clean: 
	$(COMPOSE) down
	docker rm -f wp_populate_volume
	docker rm -f mariadb_populate_volume

fclean: clean
	$(RM) $(WORDPRESS_HOST_VOLUME_PATH) $(MARIADB_HOST_VOLUME_PATH)

re: fclean all

# Create a directory with the current wordpress installation, in order to use
# it as a volume at runtime and allow data to persist.

$(WORDPRESS_HOST_VOLUME_PATH):
	# Give the container 10 seconds for the container to start and for wordpress to be copied
	mkdir -p $(WORDPRESS_HOST_VOLUME_PATH)
	docker run --name wp_populate_volume -d wordpress sleep 10
	docker cp wp_populate_volume:/var/www/wordpress $(WORDPRESS_HOST_VOLUME_PATH)
	docker kill wp_populate_volume

$(MARIADB_HOST_VOLUME_PATH):
	# Give the container 15 seconds for the container to start and for DB to be copied
	mkdir -p $(MARIADB_HOST_VOLUME_PATH)
	docker run --name mariadb_populate_volume -d mariadb sleep 15
	docker cp mariadb_populate_volume:/var/lib/mysql $(MARIADB_HOST_VOLUME_PATH)
	docker kill mariadb_populate_volume

.PHONY: build up clean fclean all re
