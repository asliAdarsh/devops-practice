# Task 7: The Intruder - Ephemeral Filesystem

## Task Overview

Learn a fundamental Docker concept: **containers have ephemeral (temporary) filesystems**. Any files created inside a container are lost when the container is removed. This task demonstrates why data persistence solutions (volumes, bind mounts) exist.

## Key Concepts

- **Ephemeral storage**: Every container starts with a fresh filesystem based on its image
- **Container lifecycle**: When you `docker rm` a container, all its internal data is destroyed
- **Immutable infrastructure**: Containers are designed to be throwaway; never store data inside them
- **Persistence solutions**: Volumes and bind mounts (covered in later tasks) solve this problem
- **docker commit**: You CAN save a container's state as a new image, but this is an anti-pattern

## Files in This Task

| File | Purpose |
|------|---------|
| `dockerfile` | Creates an Alpine container that generates files on startup |
| `docker-compose.yaml` | Defines the service for easy orchestration |
| `README.md` | This file - instructions and concepts |

## Step-by-Step Instructions

### Step 1: Build and start the container

```bash
cd docker-tasks/task-7-ephemeral-fs
docker compose up --build
```

The container will:
1. Create a file called `/data/secret.txt` with a message
2. Append a timestamp to `/data/visits.log`
3. Print the contents of `/data/`
4. Exit

### Step 2: Run it again

```bash
docker compose up
```

Notice that the second run starts fresh - the `/data/visits.log` file from the first run is gone!

### Step 3: Prove the data is lost

```bash
# Check if the container still exists
docker ps -a | grep ephemeral

# Try to access the data directory (it's gone with the container)
docker run --rm alpine ls /data  # This won't have our files
```

### Step 4: The anti-pattern (commit)

```bash
# DON'T do this in production!
docker commit ephemeral-fs-app-1 saved-image
docker run --rm saved-image cat /data/secret.txt
```

## Verification Steps

1. First run: `visits.log` should show 1 entry
2. Second run: `visits.log` should show only 1 entry again (fresh start!)
3. `docker ps -a` shows the container status after exit
4. Running the container a third time confirms no data persists

## Common Mistakes

1. **Thinking data survives by default**: Containers are ephemeral unless you use volumes
2. **Using `docker commit` to save state**: This creates bloated images and is not reproducible
3. **Expecting stateful behavior**: Containers should be treated as cattle, not pets
4. **Confusing image layers with container data**: Image layers are read-only; container writes happen in a temporary writable layer

## Best Practices

1. **Always use volumes for persistent data**: Database files, uploads, logs should live in volumes
2. **Design containers to be disposable**: If your app crashes, you should be able to kill and restart it
3. **Use entrypoint scripts**: Generate configs or seed data at startup, not during image build
4. **Log to stdout/stderr**: Let Docker handle log collection, don't write to files inside the container

## Success Criteria

- [ ] First run creates `/data/secret.txt` with correct content
- [ ] Second run shows the file was recreated (ephemeral nature demonstrated)
- [ ] `visits.log` never accumulates more than 1 entry
- [ ] Removing the container (`docker compose down`) loses all data
- [ ] You understand why volumes are needed for persistence
