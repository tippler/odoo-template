#!/usr/bin/env bash

set -a
. ./.env
set +a

rm ${APP_PATH}/odoo-data.tar.gz || true
rm ${APP_PATH}/db-data.tar.gz || true
docker compose -f ${APP_PATH}/docker-compose.yml down
docker run --rm -v odoo-${APP}_db-data:/volume -v ${APP_PATH}:/backup   alpine   tar czf /backup/db-data.tar.gz -C /volume .
docker run --rm -v odoo-${APP}_odoo-data:/volume -v ${APP_PATH}:/backup   alpine   tar czf /backup/odoo-data.tar.gz -C /volume .
docker compose -f ${APP_PATH}/docker-compose.yml up -d 
DATE=$(date +"%Y-%m-%d-%T")
mv ${APP_PATH}/odoo-data.tar.gz ${APP_PATH}/backup/$DATE-data-backup.tar.gz
mv ${APP_PATH}/db-data.tar.gz ${APP_PATH}/backup/$DATE-db-backup.tar.gz
