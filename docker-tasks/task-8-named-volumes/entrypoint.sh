#!/bin/sh
# ==============================================
# Entrypoint script for Named Volumes Demo
# Writes timestamp to a file - data persists!
# ==============================================

echo "=== Named Volumes Demo ==="

# Check if visits.log already exists
if [ -f /data/visits.log ]; then
    echo "Existing visits.log found! Previous data has persisted."
else
    echo "No existing visits.log. Starting fresh."
fi

# Append a timestamp entry
echo "$(date) - Container was started" >> /data/visits.log

# Show the accumulated log
echo ""
echo "=== Full visit log ==="
cat /data/visits.log

echo ""
echo "=== Container will now exit ==="
echo "Run 'docker compose up' again to see that data PERSISTS!"
echo "Run 'docker compose down -v' to start fresh."
