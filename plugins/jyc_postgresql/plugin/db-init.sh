#!/bin/bash

# Show usage if no database name is provided
usage() {
    echo "Usage: $0 -n <database_name> [-u <user>] [-p <password>]"
    echo "  -n: Database name (can also be set via DB_NAME environment variable)"
    echo "  -u: Database user (default: postgres)"
    echo "  -p: Database password (default: example)"
    exit 1
}

# Default values
DB_USER="postgres"
DB_PASSWORD="example"
CLI_DB_NAME=""

# Parse command line arguments
while getopts "n:u:p:" opt; do
    case $opt in
        n) CLI_DB_NAME="$OPTARG" ;;
        u) DB_USER="$OPTARG" ;;
        p) DB_PASSWORD="$OPTARG" ;;
        ?) usage ;;
    esac
done

# Check for database name in this priority:
# 1. Environment variable
# 2. Command line argument
# 3. Show usage if neither exists
if [ -n "$DB_NAME" ]; then
    echo "Using database name from environment: $DB_NAME"
elif [ -n "$CLI_DB_NAME" ]; then
    DB_NAME="$CLI_DB_NAME"
    echo "Using database name from command line: $DB_NAME"
else
    echo "Error: Database name is required (set DB_NAME environment variable or use -n flag)"
    usage
fi

# DB does not exist
if ! psql -lqt | cut -d \| -f 1 | grep -qw $DB_NAME; then
    echo "[Postgres] Creating database..."
    createdb $DB_NAME
    echo "[Postgres] Done"
fi

# User does not exist
if ! psql -d $DB_NAME -c "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'" | grep -q 1; then
    echo "[Postgres] Setting permissions..."
    psql -d $DB_NAME -v ON_ERROR_STOP=1 << EOSQL
    DO \$\$
    BEGIN
        IF EXISTS (SELECT FROM pg_roles WHERE rolname = '$DB_USER') THEN
            ALTER ROLE $DB_USER WITH SUPERUSER CREATEDB CREATEROLE LOGIN PASSWORD '$DB_PASSWORD';
        ELSE
            CREATE USER $DB_USER WITH SUPERUSER CREATEDB CREATEROLE LOGIN PASSWORD '$DB_PASSWORD';
        END IF;
    END
    \$\$;
    
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $DB_USER;
    ALTER DEFAULT PRIVILEGES GRANT ALL ON TABLES TO $DB_USER;
    ALTER DEFAULT PRIVILEGES GRANT ALL ON SCHEMAS TO $DB_USER;
EOSQL
    echo "[Postgres] Done"

    # After all operations are done, show the DATABASE_URL
    echo ""
    echo "✨ Add this to your .env file:"
    echo "DATABASE_URL='postgres://$DB_USER:$DB_PASSWORD@127.0.0.1:5433/$DB_NAME'"
    echo ""
    echo "DATABASE_URL='postgres://$DB_USER:$DB_PASSWORD@127.0.0.1:5433/$DB_NAME'" > .env
fi

