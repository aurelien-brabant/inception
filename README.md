![abrabant's stats](https://badge42.herokuapp.com/api/stats/abrabant)
![abrabant's inception final grade](https://i.imgur.com/OdfeX7c.png)

# inception

Inception is a system administration and networking project involving docker and docker-compose, asking us to setup
multiple docker containers that work together as a complete infrastructure.

I decided to reuse an old version of my website https://aurelienbrabant.fr for the static website bonus.

# Run

## Requirements

- docke
- docker-compose **> 1.29.2**, I'm not sure but I had some issue related to .env parsing with previous versions.

## Deploy the infrastructure

You can simply `make` to build the images and deploy the container infrastructure. It should work flawlessly.
