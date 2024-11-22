#!make
OS=$(shell uname)
.DEFAULT_GOAL = help
DOCKER_COMPOSE_DEV=docker compose -f docker-compose.yml

# PROJECT_NAME
PROJECT_NAME?=game

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

init: ## install deps and build docker images
	$(DOCKER_COMPOSE_DEV) build --no-cache

up: ## start local projects
	$(DOCKER_COMPOSE_DEV) up -d

up-build: init up ## init build + up

down: ## down containers & volumes
	$(DOCKER_COMPOSE_DEV) down --remove-orphans

restart: down up ## down containers & volumes then up containers again

stop: ## stop projects
	$(DOCKER_COMPOSE_DEV) stop

logs-app: ## api logs adonis
	$(DOCKER_COMPOSE_DEV) logs -f app

logs-db: ## api logs postgres
	$(DOCKER_COMPOSE_DEV) logs -f postgres

