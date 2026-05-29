#!/bin/bash
# ===========================================
# Rate Limiting Test Script
# ===========================================
# Demonstrates how Nginx rate limiting behaves
# by sending rapid requests and showing results.

echo "========================================"
echo "  Rate Limiting Demonstration"
echo "========================================"
echo ""
echo "Sending 10 rapid requests to http://localhost:80"
echo "Rate limit: 1 request/second with burst=5"
echo ""

for i in $(seq 1 10); do
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80)
  TIMESTAMP=$(date +%H:%M:%S.%3N)

  if [ "$HTTP_CODE" = "429" ]; then
    echo "[$TIMESTAMP] Request #$i → RATE LIMITED (HTTP $HTTP_CODE)"
  elif [ "$HTTP_CODE" = "200" ]; then
    echo "[$TIMESTAMP] Request #$i → SUCCESS (HTTP $HTTP_CODE)"
  else
    echo "[$TIMESTAMP] Request #$i → OTHER (HTTP $HTTP_CODE)"
  fi
done

echo ""
echo "========================================"
echo "  Test Complete"
echo "========================================"
echo "Expected: First 6 requests succeed (1 + burst=5)"
echo "          Remaining 4 requests get rate limited (429)"
echo ""
