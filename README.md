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

/home/ostervaion/data

The containers automatically restart in case of failure, and NGINX is the only exposed service.


# INSTRUCTIONS

## Requirements

- Linux Virtual Machine
- Docker
- Docker Compose
- Make

## Domain Configuration

Edit your `/etc/hosts` file: 127.0.0.1 ostervaion.42.fr


## Environment Configuration

Modify: secrets/


In this directory there need to be a bunch of files, the .env that has the environment variables that have no sensible data and a file for each secret, that has the value of a sensible data.

- DOMAIN_NAME
- MYSQL_DATABASE
- MYSQL_USER
- Other environment variables

Sensitive credentials are stored inside the `secrets/` directory and are not hardcoded in Dockerfiles.

## Build and Launch

From the root of the repository:


