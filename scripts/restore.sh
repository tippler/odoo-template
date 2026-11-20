#!/usr/bin/env bash

set -a
. ./.env
set +a


DATE=$1
BACKUPPATH="/home/tip/docker/odoo-${APP}/backup"
DATA_VOL="odoo-${APP}_odoo-data"
DB_VOL="odoo-${APP}_db-data"

docker volume create $DATA_VOL

docker run --rm \
  -v $DATA_VOL:/volume \
  -v $BACKUPPATH:/backup \
  alpine \
  sh -c "cd /volume && tar xzf /backup/$DATE-data-backup.tar.gz"

docker volume create $DB_VOL

docker run --rm \
  -v $DB_VOL:/volume \
  -v $BACKUPPATH:/backup \
  alpine \
  sh -c "cd /volume && tar xzf /backup/$DATE-db-backup.tar.gz"
