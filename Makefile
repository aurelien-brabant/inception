#!make
include srcs/.env

PROJECT_NAME	=inception
COMPOSE			= cd srcs && docker-compose -p $(PROJECT_NAME)

NEW_FILE		= touch
RM				= rm -rf

all: .up

# build images separately, without starting the containers.

build:
	$(COMPOSE) build

# build the service's images and run the containers in the background.

.up: 
	mkdir -p $(WP_HOST_VOLUME_PATH)
	mkdir -p $(MARIADB_HOST_VOLUME_PATH)
	$(COMPOSE) up -d --build
	$(NEW_FILE) .up

# stop the containers and toggle the up state
clean: 
	$(COMPOSE) down
	$(RM) .up

# Deletes docker volumes, but persistance should remain as ~/data directories
# are left untouched. Up state is toggled as well.

fclean:
	$(COMPOSE) down -v
	$(RM) .up

re: fclean all

# /!\ ROOT ACCESS REQUIRED /!\
# Cleanup the entire docker environment as well as persistance
prune: fclean
	docker system prune --volumes --all --force
	sudo rm -rf ~/data

.PHONY: build clean fclean all re
