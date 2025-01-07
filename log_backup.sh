#!/bin/bash

LOG_DIR="/var/log/httpd"
ARCHIVE_DIR="/var/log/httpd/archive"
DAYS_TO_KEEP=3

mkdir -p "$ARCHIVE_DIR"

DATE=$(date +"%Y-%m-%d")

find "$LOG_DIR" -type f -name "*.log" -exec tar -rvf "$ARCHIVE_DIR/logs-$DATE.tar" {} \;

gzip "$ARCHIVE_DIR/logs-$DATE.tar"

find "$LOG_DIR" -type f -name "*.log" -exec truncate -s 0 {} \;

find "$ARCHIVE_DIR" -type f -name "*.tar.gz" -mtime +$DAYS_TO_KEEP -exec rm -f {} \;

echo "Архивирование логов завершено. Логи очищены. Старые архивы удалены."
