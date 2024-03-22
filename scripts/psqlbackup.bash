#!/bin/bash

# PostgreSQL server connection details
PG_HOST="prodpsql.ninhu.xyz"
PG_PORT="5432"
PG_USER=""
PG_PASSWORD=""

# Database details
DB_NAME=""

# Backup directory
BACKUP_DIR=""

# Maximum number of backup files to retain
MAX_RETENTION=30

# Current date and time
CURRENT_DATE=$(date +"%Y-%m-%d_%H%M")

# Backup file name
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${CURRENT_DATE}.sql"

# Perform the database backup
PGPASSWORD="" pg_dump -h $PG_HOST -p $PG_PORT -U $PG_USER -F c -b -f $BACKUP_FILE -d $DB_NAME
# pg_dump -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -W "$PG_PASSWORD" -F c -b -v -f "$BACKUP_FILE" "$DB_NAME"

# Remove old backup files exceeding maximum retention
ls -t ${BACKUP_DIR}/${DB_NAME}_*.sql | tail -n +$((MAX_RETENTION + 1)) | xargs -I {} rm {}

echo "Backup completed successfully."
