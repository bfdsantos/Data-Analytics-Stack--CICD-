#!/bin/bash

# Variables
DB_NAME="${POSTGRES_DB}"
DB_USER="${POSTGRES_USER}"
DUMP_FILE="/dump/webshop.dump"

# Restore the database
pg_restore -d $DB_NAME $DUMP_FILE -U $DB_USER

# Rename the schema to raw
psql -U $DB_USER -d $DB_NAME -c "ALTER SCHEMA public RENAME TO raw;" -c "CREATE SCHEMA public;"
