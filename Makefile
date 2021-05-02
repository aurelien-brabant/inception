#!make
include srcs/.env

PROJECT_NAME	= inception

# -f is not used because --env-file is not available on the version of docker-compose
# the VM uses.
COMPOSE			= cd srcs && docker-compose -p $(PROJECT_NAME)

NEW_FILE		= touch
RM				= rm -rf

all: .up

# build images separately, without starting the containers.

build:
	$(COMPOSE) build

# build the service's images and run the containers in the background.
# ensure containers are down before performing up.
.up: clean 
	mkdir -p $(WP_HOST_VOLUME_PATH)
	mkdir -p $(MARIADB_HOST_VOLUME_PATH)
	$(COMPOSE) up -d --build

# stop the containers 
clean: 
	$(COMPOSE) down

# Deletes docker volumes, but persistance should remain as ~/data directories
# are left untouched. 
fclean:
	$(COMPOSE) down -v

# Delete docker volumes and up (data should persist)
re: fclean all

# /!\ ROOT ACCESS REQUIRED /!\
# Cleanup the entire docker environment as well as volumes that persisted.
prune: fclean
	docker system prune --volumes --all --force
	sudo rm -rf ~/data

.PHONY: build clean fclean all re .up
