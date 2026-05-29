# Task 10: Bridge Builder - Bind Mounts

## Task Overview
Learn how to use **bind mounts** to share files between your host and a container. Unlike named volumes, bind mounts map a specific host directory into the container.

## Key Concepts
- **Bind Mount**: Maps a host file/directory into a container at a specified path
- **Live Reload**: Changes on the host are immediately reflected in the container
- **Absolute Paths**: Bind mounts require absolute paths on the host
- **Read-Only Mounts**: Mount with `:ro` to prevent container from modifying host files

## Files in This Task

| File | Purpose |
|------|---------|
| `docker-compose.yaml` | Defines a web service with a bind mount |
| `html/index.html` | HTML file on the host that Nginx serves |

## Step-by-Step Instructions

### 1. Start the service
```bash
cd docker-tasks/task-10-bind-mounts
docker compose up -d
```

### 2. Edit the HTML file while Nginx is running
```bash
echo "<h1>Updated Content</h1>" > html/index.html
# Refresh http://localhost:8080 - the change appears immediately!
```

## Verification Steps
- [ ] Bind mount is created and accessible at `http://localhost:8080`
- [ ] Changes to host files appear instantly in the container
- [ ] `docker inspect` shows the bind mount details

## Success Criteria
- [ ] Container serves the HTML file from the host
- [ ] Editing the file on the host immediately updates the served content
- [ ] Understanding the difference between bind mounts and named volumes
