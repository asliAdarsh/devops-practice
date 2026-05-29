#!/bin/sh
# ==============================================
# Entrypoint script for Ephemeral Filesystem Demo
# Creates a file and shows it disappears on restart
# ==============================================

echo "=== Ephemeral Filesystem Demo ==="

# Create a secret file
echo "This file was created at: $(date)" > /data/secret.txt
echo "Created /data/secret.txt"

# Append a visit to the log
echo "Visit at $(date)" >> /data/visits.log
echo "Logged visit to /data/visits.log"

# Show the contents of /data/
echo ""
echo "=== Contents of /data/ ==="
ls -la /data/

echo ""
echo "=== Contents of visits.log ==="
cat /data/visits.log

echo ""
echo "=== Container will now exit ==="
echo "Run 'docker compose up' again to see that data is LOST!"
