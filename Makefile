PROJECT = nodejs
CURRENT_DIR = $(shell pwd | sed -e "s/\/cygdrive//g")

destroy: 
	docker-machine rm -f $(DOCKER_MACHINE_NAME)

.PHONY: start
start: 
	docker-compose -f docker-compose.yml -p $(PROJECT) up -d --build

.PHONY: restart
restart: 
	docker-compose -f docker-compose.yml -p $(PROJECT) kill && \
	docker-compose -f docker-compose.yml -p $(PROJECT) rm -f --all && \
	docker-compose -f docker-compose.yml -p $(PROJECT) up -d --build

ps: 
	docker-compose -f docker-compose.yml -p $(PROJECT) ps

.PHONY: kill
kill:
	docker-compose -f docker-compose.yml -p $(PROJECT) kill

.PHONY: logs
logs:
	docker-compose -f docker-compose.yml -p $(PROJECT) logs --follow