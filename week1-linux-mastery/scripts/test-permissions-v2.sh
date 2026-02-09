#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/opt/app-data"
DB_DIR="/opt/db-data"

echo "Testing $APP_DIR permissions..."
sudo -u alice_appuser bash -c "echo 'alice_appuser test' > '$APP_DIR/appuser.txt'" \
  && echo "✓ alice_appuser can write to $APP_DIR" \
  || echo "✗ alice_appuser cannot write to $APP_DIR"

echo "Testing $DB_DIR permissions..."
sudo -u tom_dbuser bash -c "echo 'tom_dbuser test' > '$DB_DIR/dbuser.txt'" \
  && echo "✓ tom_dbuser can write to $DB_DIR" \
  || echo "✗ tom_dbuser cannot write to $DB_DIR"

echo "Current perms:"
sudo -u alice_appuser ls -la "$APP_DIR"
sudo -u tom_dbuser ls -la "$DB_DIR"
EOF