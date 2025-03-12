#!/bin/bash

# Database connection variables
DB_NAME="${POSTGRES_DB}"
DB_USER="${POSTGRES_USER}"
DB_PASSWORD="${POSTGRES_PASSWORD}"

# Foreign database connection variables
#DB_NAME="${POSTGRES_DB}" --DB name is the same in DEV and PRD
FOREIGN_DB_HOST="prod_postgres"
FOREIGN_DB_PORT="5432" #internal port of prod, inside the container

# Schema variables
FOREIGN_SCHEMA="raw"
RAW_SCHEMA="raw_prod"

# SQL commands
SQL_COMMANDS="
CREATE EXTENSION IF NOT EXISTS postgres_fdw;
CREATE SERVER IF NOT EXISTS $FOREIGN_DB_HOST FOREIGN DATA WRAPPER postgres_fdw OPTIONS (dbname '$DB_NAME', host '$FOREIGN_DB_HOST', port '$FOREIGN_DB_PORT');
CREATE USER MAPPING IF NOT EXISTS FOR CURRENT_USER SERVER $FOREIGN_DB_HOST OPTIONS (user '$DB_USER', password '$DB_PASSWORD');
IMPORT FOREIGN SCHEMA $FOREIGN_SCHEMA FROM SERVER $FOREIGN_DB_HOST INTO public;
ALTER SCHEMA public RENAME TO $RAW_SCHEMA;
"

# Execute SQL commands using psql
psql -U $DB_USER -d $DB_NAME -c "$SQL_COMMANDS"
