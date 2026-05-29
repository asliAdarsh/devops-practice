# Task 8: Time Traveler - Named Volumes

## Task Overview

Learn how to persist data across container restarts using **Docker named volumes**. Named volumes are the preferred way to store data that should survive container removal.

## Key Concepts

- **Named volume**: A Docker-managed storage location that persists independently of containers
- **Volume lifecycle**: Volumes survive container removal and can be reused by new containers
- **Volume mount syntax**: `source:destination` where source is the volume name and destination is the container path
- **docker volume commands**: `docker volume ls`, `docker volume inspect`, `docker volume rm`
- **Anonymous vs named volumes**: Anonymous volumes (auto-generated names) are harder to manage; named volumes are explicit

## Files in This Task

| File | Purpose |
|------|---------|
| `docker-compose.yaml` | Defines the app service with a named volume |
| `dockerfile` | Creates an Alpine container with a data-writing script |
| `README.md` | Instructions and concepts |

## Step-by-Step Instructions

### Step 1: Start the application

```bash
cd docker-tasks/task-8-named-volumes
docker compose up --build
```

The app writes a timestamp and message to `/data/visits.log`.

### Step 2: Verify data was written

```bash
docker compose down
docker compose up
```

The log file will now have TWO entries - the data from the first run persisted!

### Step 3: Inspect the volume

```bash
docker volume ls
docker volume inspect task-8-named-volumes_app_data
```

### Step 4: Destroy and recreate

```bash
docker compose down -v  # The -v flag removes volumes too
docker compose up        # Starts fresh - only 1 entry
```

## Verification Steps

1. First run: 1 entry in visits.log
2. Second run (without `-v`): 2 entries - data persisted!
3. `docker volume ls` shows the named volume exists
4. `docker compose down -v` + `docker compose up` starts fresh again

## Common Mistakes

1. **Forgetting to define volumes in compose**: Without a `volumes:` section at the bottom of compose, named volumes won't be created
2. **Using `down -v` accidentally**: This destroys volumes; be careful in production!
3. **Confusing volumes with bind mounts**: Volumes are managed by Docker; bind mounts are host directories
4. **Not cleaning up orphan volumes**: Use `docker volume prune` to remove unused volumes

## Best Practices

1. **Always name your volumes**: Avoid anonymous volumes for production data
2. **Use `docker compose down -v` sparingly**: Only when you want a complete reset
3. **Label your volumes**: Add labels for easier management
4. **Back up volumes regularly**: Use `docker run --rm -v source_volume:/source -v $(pwd):/backup alpine tar czf /backup/backup.tar.gz -C /source .`

## Success Criteria

- [ ] First run creates a timestamp entry in visits.log
- [ ] Second run shows accumulated data (2+ entries)
- [ ] `docker volume ls` shows the named volume
- [ ] Volume data survives `docker compose down` (without `-v`)
- [ ] `docker compose down -v` resets the data
