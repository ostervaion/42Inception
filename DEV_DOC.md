# Set up the environment from scratch (prerequisites, configuration files, secrets)

The needed environment variables are the next ones:

MYSQL_HOST=mariadb (not really needed)
WP_URL=https://juetxeba.42.fr (the domain name, it can be changed)
WP_TITLE=Inception WordPress (Title for wordpress)

# Build and launch the project using the Makefile and Docker Compose

Docker compose is used inside the makefile.

From the root of the repository:

- Build and start the containers
    make upb
- Start the containers (already build):
    make up
- Stop the containers:
    make down
- Stop the containers and clear the data:
    make downv
- Build the containers:
    make build

# Use relevant commands to manage the containers and volumes

See the containers:

docker ps

See the volumes:

docker volumes ls

Execute a command inside the container

docker exec -it <container-name> <command-to-be-used> (/bin/sh to open a shell inside the container)

# Identify where the project data is stored and how it persists

The data is inside the /home/<login>/Data and it persists because is set as a volume by the docker compose.
