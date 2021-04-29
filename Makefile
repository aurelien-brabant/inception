WORDPRESS_HOST_VOLUME=~/wordpress
MARIADB_HOST_VOLUME=~/mariadb

all: $(WORDPRESS_HOST_VOLUME) $(MARIADB_HOST_VOLUME)

# Create a directory with the current wordpress installation, in order to use
# it as a volume at runtime and allow data to persist.

$(WORDPRESS_HOST_VOLUME):
	# Give the container 10 seconds for the container to start and for wordpress to be copied
	docker run --name wp_populate_volume -d wordpress sleep 10
	docker cp wp_populate_volume:/var/www/wordpress $(WORDPRESS_HOST_VOLUME)
	docker kill wp_populate_volume
	docker rm wp_populate_volume

$(MARIADB_HOST_VOLUME):
	# Give the container 15 seconds for the container to start and for DB to be copied
	docker run --name mariadb_populate_volume -d mariadb sleep 15
	docker cp mariadb_populate_volume:/var/lib/mysql $(MARIADB_HOST_VOLUME)
	docker kill mariadb_populate_volume
	docker rm mariadb_populate_volume
