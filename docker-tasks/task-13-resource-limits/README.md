# Task 13: The Constrainer - Resource Limits

## Task Overview
Learn how to set **CPU and memory limits** on Docker containers to prevent a single container from consuming all host resources.

## Key Concepts
- **Memory Limits**: `--memory` / `mem_limit` restricts max RAM a container can use
- **CPU Limits**: `--cpus` / `cpus` restricts CPU cores available
- **OOM Killer**: Linux kills containers that exceed memory limits
- **Resource Guarantees**: Reservations ensure minimum resources are available

## Files in This Task

| File | Purpose |
|------|---------|
| `docker-compose.yaml` | Service with CPU and memory limits |
| `stress-test.sh` | Script to simulate resource usage |

## Step-by-Step Instructions

### 1. Start the container
```bash
cd docker-tasks/task-13-resource-limits
docker compose up -d
```

### 2. Monitor resource usage
```bash
docker stats
```

### 3. Test limits
```bash
# Try to allocate more memory than the limit
docker exec -it task-13-resource-limits-web-1 stress --vm 1 --vm-bytes 200M --timeout 10
# The process will be killed by OOM killer
```

## Success Criteria
- [ ] Container starts with resource limits applied
- [ ] `docker stats` shows the limits
- [ ] Exceeding memory limit causes container to restart
- [ ] Understanding how resource limits protect the host
