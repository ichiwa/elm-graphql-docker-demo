PROJECT = nodejs
CURRENT_DIR = $(shell pwd | sed -e "s/\/cygdrive//g")

.PHONY: destroy
ifeq (destroy,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
destroy:
	docker-compose -f docker-compose.yml -p $(PROJECT) rm -f $(RUN_ARGS)

.PHONY: start
ifeq (start,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
start: ## Create and start containers : ## make up
	docker-compose -f docker-compose.yml -p $(PROJECT) up -d --build $(RUN_ARGS)

.PHONY: restart
ifeq (restart,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
restart: ## Restart services : ## make restart
	docker-compose -f docker-compose.yml -p $(PROJECT) kill $(RUN_ARGS) && \
	docker-compose -f docker-compose.yml -p $(PROJECT) rm -f $(RUN_ARGS) && \
	docker-compose -f docker-compose.yml -p $(PROJECT) up -d --build $(RUN_ARGS)

.PHONY: ps
ps: ## List containers : ## make ps
	docker-compose -f docker-compose.yml -p $(PROJECT) ps

.PHONY: kill
ifeq (kill,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
kill: ## kill containers : ## make kill
	docker-compose -f docker-compose.yml -p $(PROJECT) kill $(RUN_ARGS)

.PHONY: logs
ifeq (logs,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
logs: ## Display container's log : ## make logs
	docker-compose -f docker-compose.yml -p $(PROJECT) logs --follow --timestamps $(RUN_ARGS)