# Task 10: JSON Logging (The Data Miner)

## Task Overview
Learn how to configure Nginx to output logs in **JSON format** instead of the default combined format. JSON logs are machine-readable and can be easily parsed by log aggregation tools like Elasticsearch, Logstash, Splunk, or Datadog.

## Key Concepts
- **`log_format`**: Defines a custom log format using variables
- **`access_log`**: Specifies where to write access logs and which format to use
- **JSON logging**: Outputs log entries as JSON objects for easy parsing
- **`$remote_addr`**: Client IP address
- **`$request`**: The full HTTP request line (method, path, protocol)
- **`$status`**: HTTP response status code
- **`$body_bytes_sent`**: Size of the response body
- **`$http_referer`**: Referrer URL
- **`$http_user_agent`**: Client user agent string
- **`$request_time`**: Time taken to process the request (seconds)
- **`$upstream_response_time`**: Time the backend took to respond
- **Conditional logging**: Log only certain requests (e.g., errors only)
- **Log buffering**: Improve performance by buffering log writes

## Files in This Task

| File | Purpose |
|------|---------|
| `README.md` | This file — explains the task |
| `nginx.conf` | Nginx config with JSON log format |
| `dockerfile` | Docker image for Nginx with JSON logging |
| `docker-compose.yaml` | Spins up Nginx + backend |

## Step-by-Step Instructions

### 1. Start the Services
```bash
cd task-10-json-logging
docker compose up --build
```

### 2. Generate Some Traffic
```bash
# Make a few requests to generate log entries
curl http://localhost:80
curl http://localhost:80/test
curl http://localhost:80/notfound
curl -A "TestBot/1.0" http://localhost:80
```

### 3. View JSON Logs
```bash
# Check the Nginx access logs
docker compose exec nginx cat /var/log/nginx/access.json.log

# You should see output like:
# {"timestamp":"2024-01-01T12:00:00+00:00","remote_addr":"172.20.0.1","method":"GET",...}
```

### 4. Parse JSON Logs with jq
```bash
# If you have jq installed, you can pretty-print and query the logs
docker compose exec nginx cat /var/log/nginx/access.json.log | jq '.'

# Find all 404 errors
docker compose exec nginx cat /var/log/nginx/access.json.log | jq 'select(.status == 404)'

# Show slow requests (>0.5 seconds)
docker compose exec nginx cat /var/log/nginx/access.json.log | jq 'select(.request_time > 0.5)'

# Count requests per status code
docker compose exec nginx cat /var/log/nginx/access.json.log | jq -r '.status' | sort | uniq -c
```

### 5. View Error Logs
```bash
# Error logs are also in JSON format
docker compose exec nginx cat /var/log/nginx/error.json.log
```

## Verification Steps

```bash
# Verify JSON format is valid
docker compose exec nginx cat /var/log/nginx/access.json.log | head -5
# Each line should be a valid JSON object

# Check that all expected fields are present
docker compose exec nginx cat /var/log/nginx/access.json.log | head -1 | jq 'keys'

# Verify the log contains request details
docker compose exec nginx cat /var/log/nginx/access.json.log | jq '{method, path, status, request_time}'

# Check error log format
docker compose exec nginx cat /var/log/nginx/error.json.log

# Verify different status codes are logged
docker compose exec nginx cat /var/log/nginx/access.json.log | jq -r '.status' | sort -n
```

## Common Mistakes

| Mistake | What Happens | How to Fix |
|---------|-------------|------------|
| Invalid JSON format (missing commas) | Nginx won't start (config test fails) | Carefully escape quotes and use proper JSON syntax |
| Not escaping double quotes in variables | Malformed JSON output | Use `escape=json` in the log_format directive |
| Exceeding log file size limits | Disk fills up and Nginx stops | Use log rotation (`logrotate`) or set `max_size` |
| Logging too much detail | Performance degradation from I/O | Use buffering (`buffer=32k flush=5s`) |
| Wrong path in `access_log` | No logs generated | Verify the directory exists and is writable |

## Best Practices
1. **Always use `escape=json`** in your log_format to properly escape special characters in variables
2. **Use log buffering** (`buffer=32k flush=5s`) to improve write performance
3. **Separate access and error logs** — they serve different purposes
4. **Implement log rotation** to prevent disks from filling up
5. **Log only what you need** — too many fields increase storage costs
6. **Include `$request_time`** to identify slow endpoints that need optimization
7. **Use conditional logging** — skip logging for health checks and static assets to reduce noise

## Success Criteria
- [ ] Access logs are in valid JSON format
- [ ] Each log entry includes: timestamp, IP, method, path, status, response time
- [ ] Error logs are also in JSON format
- [ ] Logs can be parsed with `jq` or any JSON parser
- [ ] Queries can extract specific data (e.g., all 404 errors)
- [ ] Special characters in variables are properly escaped
