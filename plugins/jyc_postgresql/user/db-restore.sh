#!/bin/bash

# Prepare things for you
jyc_postgresql_dir="./.devbox/virtenv/jycouet.devbox.jyc_postgresql"
source "$jyc_postgresql_dir/helpers.sh"

## ---Your custom things---

BACKUP_FILE="../backup/db.$DB_NAME.dmp"

execute_and_log "Database restore" "pg_restore -U postgres -d \"$DB_NAME\" \"$BACKUP_FILE\""
