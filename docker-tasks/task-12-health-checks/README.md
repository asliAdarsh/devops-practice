# Task 12: Health Checker - Container Health Checks

## Task Overview
Learn how to configure **Docker health checks** to monitor container status and enable automatic recovery of unhealthy containers.

## Key Concepts
- **HEALTHCHECK Instruction**: Dockerfile directive that defines how to test container health
- **health check states**: starting, healthy, unhealthy
- **Interval, Timeout, Retries**: Configure how often and how many times to check
- **Auto-Recovery**: Docker Compose can restart unhealthy containers automatically

## Files in This Task

| File | Purpose |
|------|---------|
| `dockerfile` | Web app with HEALTHCHECK instruction |
| `docker-compose.yaml` | Service with restart policies |

## Step-by-Step Instructions

### 1. Build and start
```bash
cd docker-tasks/task-12-health-checks
docker compose up --build
```

### 2. Check container health
```bash
docker ps
docker inspect --format='{{json .State.Health}}' task-12-health-checks-web-1
```

### 3. Simulate failure
```bash
# The app has an endpoint to crash itself:
curl http://localhost:8080/crash
# Watch Docker restart the container automatically
```

## Success Criteria
- [ ] Container starts and shows "healthy" status
- [ ] `docker inspect` shows health check details
- [ ] Unhealthy containers are automatically restarted
- [ ] Health check logs are visible in container events
