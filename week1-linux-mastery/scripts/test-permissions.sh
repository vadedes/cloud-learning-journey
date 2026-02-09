#!/bin/bash
echo "Testing /opt/app-data permissions..."

#Test alice_appuser access
sudo -u alice_appuser bash -c "echo 'alice_appuser test' > /opt/app-data/appuser.txt" && \
 echo "✓ appuser can write" || echo "✗ appuser cannot write"

#Test tom_dbuser access
sudo -u tom_dbuser bash -c "echo 'tom_dbuser test' > /opt/db-data/dbuser.txt" && \
 echo "✓ tom_dbuser can write" || echo "✗ tom_dbuser cannot write"

# Show current permissions
sudo -u alice_appuser ls -la /opt/app-data/
sudo -u tom_dbuser ls -la /opt/db-data/
EOF