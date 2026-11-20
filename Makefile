# Variables
include .env


.PHONY: all build test lint format run clean help

run up all:
	@echo "Running $(APP)..."
	docker compose  -f $(APP_PATH_COMPOSE) up -d --remove-orphans

down stop:
	@echo "Down $(APP)..."
	docker compose  -f $(APP_PATH_COMPOSE) down --remove-orphans

create:
	@echo "Creating $(APP)..."
	docker volume create odoo-$(APP)_db-data
	docker volume create odoo-$(APP)_odoo-data
	$(MAKE) up

cleanup teardown destroy delete:
	@echo "Cleanup $(APP)..."
	docker compose  -f $(APP_PATH_COMPOSE) down -v --remove-orphans
	docker volume remove odoo-$(APP)_db-data
	docker volume remove odoo-$(APP)_odoo-data

install-addons:
	@echo Install modules" $(APP)..."
	sed -e "s/{{ID}}/$(INSTALL_MODULES)/g" templates/install-addons.sh > custom-addons/install.sh
	chmod +x custom-addons/install.sh
	docker compose run odoo /mnt/extra-addons/install.sh

download-addons:
	./scripts/download-addons.sh

do-backup:
	@echo Executing backup script" $(APP)..."
	scripts/backup.sh

update:
	@echo Updating" $(APP)..."
	docker compose pull
	docker compose restart
	docker image prune -f
	docker container prune -f
	docker builder prune -f
help:
	@echo "Targets:"
	@echo "  create"
	@echo "  up"
	@echo "  down"
	@echo "  destroy"
	@echo "  do-backup"
	@echo "  install-addons"
	@echo "  download-addons"
	@echo "  update" 
