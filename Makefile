COMPOSE_FILE=docker-compose.yml
COMPOSES := $(shell find . -name compose.yaml)

GATEWAY_COMPOSE=./gateway/compose.yaml
BROKER_COMPOSE=./broker/compose.yaml

.PHONY: all gateway broker

all:
	@for f in $(COMPOSES); do \
		dir=$$(dirname $$f); \
		echo "Starting $$dir"; \
		docker compose -f $$f up -d; \
	done

down-all:
	@for f in $(COMPOSES); do \
		dir=$$(dirname $$f); \
		echo "Stopping $$dir"; \
		docker compose -f $$f down; \
	done

gateway:
	docker compose -f $(GATEWAY_COMPOSE) up -d

broker:
	docker compose -f $(BROKER_COMPOSE) up -d
