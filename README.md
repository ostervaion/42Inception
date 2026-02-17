*This project has been created as part of the 42 curriculum by juetxeba*

# DESCRIPTION

Inception is a System Administration project from the 42 curriculum.

The goal of this project is to build a secure and modular web infrastructure using Docker and Docker Compose, entirely configured from custom Dockerfiles and executed inside a Virtual Machine.

The infrastructure consists of:

- An NGINX container with TLSv1.2 or TLSv1.3 (only public entrypoint on port 443)
- A WordPress container running php-fpm (without nginx)
- A MariaDB container (without nginx)
- Two Docker named volumes for persistent storage
- A dedicated Docker bridge network connecting the services

Each service runs in its own container and is built from scratch using Alpine or Debian (penultimate stable version).  
No pre-built service images are used (except base Alpine/Debian images).

All persistent data is stored inside:

/home/juetxeba/data

The containers automatically restart in case of failure, and NGINX is the only exposed service.


# INSTRUCTIONS

## Requirements

- Root access
- Docker
- Docker Compose
- Make

## Domain Configuration

Edit your `/etc/hosts` file: 127.0.0.1 juetxeba.42.fr


## Environment Configuration

Modify: secrets/


In this directory there need to be a bunch of files, the .env that has the environment variables that have no sensible data and a file for each secret, that has the value of a sensible data.

Sensitive credentials are stored inside the `secrets/` directory and are not hardcoded in Dockerfiles.

This are the names of the secret files, each one has its value:
- cert.pem
- db_name
- db_password
- db_r_password
- db_user
- key.pem
- wp_admin_email
- wp_admin_password
- wp_admin_user
- wp_user
- wp_user_email
- wp_user_password

This are the variables in the .env:

- MYSQL_HOST=wordpress
- WP_URL=https://juetxeba.42.fr
- WP_TITLE=Inception WordPress

## Build and Launch

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

## After running containers

To access the wordpress with your favourite browser go to https://localhost:443

To log in search for https://localhost:443/wp-admin

# RESOURCES

- https://docs.docker.com/ ----For docker compose and dockerfile info----
- https://mariadb.com/docs ----For mariadb documentation----
- https://wordpress.org/documentation/ ----For wordpress documentation----
- https://nginx.org/en/docs/  ----For nginx documentation ----
- https://wiki.alpinelinux.org/wiki/Main_Page ----For alpine installation info----

AI was used in this project to generate examples and explanations of the configuration files for each service and the dockerfiles.

# ADDITIONAL PROJECT DESCRIPTION

-------Virtual Machines vs Docker------------

Virtual Machines virtualize hardware and require a full operating system per instance.  
They consume more resources and have slower startup times.

Docker containers share the host kernel and isolate processes instead of hardware.  
They are lightweight, start quickly, and are ideal for service-based infrastructures.

This project uses Docker for efficient isolation and reproducibility.


-------Secrets vs Environment Variables------------

Environment Variables are used for configuration values such as domain name or database name.

Docker Secrets are used to securely store sensitive data like passwords.

Environment variables are easy to configure but visible in container environments.  
Secrets provide stronger protection and prevent credentials from being exposed in Dockerfiles or Git repositories.

This project separates configuration from credentials to improve security.


-------Docker Network vs Host Network------------

Docker Bridge Network provides isolated communication between containers.

Host Network shares the host's network stack and removes isolation.

For security and subject compliance, a custom Docker bridge network is used.  
No `--link` or `network: host` options are used.


-------Docker Volumes vs Bind Mounts------------

Docker Volumes are managed by Docker and ensure persistent storage independent of containers.

Bind Mounts directly map host directories into containers.

This project uses Docker named volumes (mandatory in the subject) to store:

- WordPress database data
- WordPress website files

All data is stored in:

/home/juetxeba/data

Usually volumes are set in a docker defined directory, but the subject asks for it being in this path, so the way to do it is by doing a pseudo bind. This means that the path is changed but docker still treats it as a volume.
