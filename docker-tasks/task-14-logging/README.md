# Task 14: The Logger - Logging & Debugging

## Task Overview
Learn how to manage and configure **Docker container logs**, use different logging drivers, and debug container issues effectively.

## Key Concepts
- **Default Logger**: json-file driver stores logs as JSON files
- **Logging Drivers**: json-file, syslog, journald, fluentd, awslogs, gcp, etc.
- **Log Rotation**: Prevent logs from filling up disk space
- **docker logs**: View container stdout/stderr output
- **docker events**: Stream real-time events from the Docker daemon

## Files in This Task

| File | Purpose |
|------|---------|
| `docker-compose.yaml` | Service with log rotation configured |
| `app.py` | Python app that generates structured logs |

## Step-by-Step Instructions

### 1. Start the app
```bash
cd docker-tasks/task-14-logging
docker compose up --build
```

### 2. View logs
```bash
docker compose logs -f
```

### 3. Check log file location
```bash
docker inspect task-14-logging-app-1 | grep LogPath
```

## Success Criteria
- [ ] Container starts and generates log output
- [ ] `docker compose logs` shows structured log messages
- [ ] Log rotation is configured (max-size, max-file)
- [ ] Understanding different logging drivers
