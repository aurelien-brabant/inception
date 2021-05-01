#!make
include srcs/.env

PROJECT_NAME=inception
RM=rm -rf
COMPOSE=cd srcs && docker-compose -p $(PROJECT_NAME)
NEW_FILE=touch

all: .up

$(WORDPRESS_HOST_VOLUME_PATH):
	mkdir -p $(WORDPRESS_HOST_VOLUME_PATH)

$(MARIADB_HOST_VOLUME_PATH):
	mkdir -p $(MARIADB_HOST_VOLUME_PATH)

build:
	$(COMPOSE) build

.up: $(MARIADB_HOST_VOLUME_PATH) $(WORDPRESS_HOST_VOLUME_PATH)
	mkdir -p $(WORDPRESS_HOST_VOLUME_PATH)
	mkdir -p $(MARIADB_HOST_VOLUME_PATH)
	$(COMPOSE) up -d --build
	$(NEW_FILE) .up

clean: 
	$(COMPOSE) down
	$(RM) .up

# deletes docker volumes, but persistance should remain as ~/data directories
# are left untouched.

fclean: clean
	$(COMPOSE) down -v

re: fclean all

#$(WORDPRESS_HOST_VOLUME_PATH):
#	mkdir -p ~/data
#	docker run --name wp_populate_volume -d wordpress sleep 60
#	docker cp wp_populate_volume:/var/www/wordpress $(WORDPRESS_HOST_VOLUME_PATH)
#	docker kill wp_populate_volume
#
#$(MARIADB_HOST_VOLUME_PATH):
#	mkdir -p ~/data
#	docker run --name mariadb_populate_volume -d mariadb sleep 60
#	docker cp mariadb_populate_volume:/var/lib/mysql $(MARIADB_HOST_VOLUME_PATH)
#	docker kill mariadb_populate_volume

.PHONY: build clean fclean all re
