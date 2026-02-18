SRCDC = srcs/docker-compose.yml

create_volumes:
	@mkdir -p ~/data/mariadb-volume
	@mkdir -p ~/data/wordpress-volume
upb: create_volumes
	@echo "Building and starting containers"
	@docker compose -f $(SRCDC) up --build -d
upb_attacked: create_volumes
	@echo "Building and starting containers"
	@docker compose -f $(SRCDC) up --build
up: create_volumes
	@echo "Starting containers"
	@docker compose -f $(SRCDC) up -d
down:
	@echo "Stopping containers and networks"
	@docker compose -f $(SRCDC) down
downv:
	@echo "Stopping containers and networks while destroying volumes"
	@docker compose -f $(SRCDC) down -v
	@sudo rm -r ~/data/wordpress-volume
	@sudo rm -r ~/data/mariadb-volume
build:
	@echo "Building container images"
	@docker compose -f $(SRCDC) build
