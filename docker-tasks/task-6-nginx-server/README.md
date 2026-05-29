# Task 6: The Instant Server - Basic Nginx

## Task Overview

Learn how to serve a static HTML page using the official Nginx image from Docker Hub. This is one of the simplest Docker use cases: take a pre-built web server image, add your content, and run it.

## Key Concepts

- **Base images**: Starting from `nginx:alpine` gives you a tiny, production-ready web server
- **COPY instruction**: Moves files from your host into the container's filesystem
- **Port mapping** (`-p`): Connects a host port to a container port so you can access the web server
- **Detached mode** (`-d`): Runs the container in the background
- **Alpine Linux**: A minimal Linux distribution (~5MB) that keeps images small

## Files in This Task

| File | Purpose |
|------|---------|
| `dockerfile` | Builds the image using nginx:alpine and copies index.html |
| `index.html` | A simple "Hello from Docker Nginx!" HTML page |

## Step-by-Step Instructions

### Step 1: Build the Docker image

```bash
cd docker-tasks/task-6-nginx-server
docker build -t nginx-server .
```

- `-t nginx-server` gives your image the name `nginx-server`
- `.` tells Docker to look for the dockerfile in the current directory

### Step 2: Run the container

```bash
docker run -d -p 8080:80 --name my-nginx nginx-server
```

- `-d` runs in detached (background) mode
- `-p 8080:80` maps port 8080 on your host to port 80 inside the container
- `--name my-nginx` gives the container a friendly name

### Step 3: View the page

Open your browser and go to: [http://localhost:8080](http://localhost:8080)

Or use curl in your terminal:

```bash
curl http://localhost:8080
```

### Step 4: Clean up

```bash
docker stop my-nginx
docker rm my-nginx
```

## Verification Steps

1. Run `docker ps` to confirm the container is running
2. Visit `http://localhost:8080` - you should see "Hello from Docker Nginx!"
3. Run `docker logs my-nginx` to see Nginx access logs
4. Run `docker inspect my-nginx` to see container configuration details

## Common Mistakes

1. **Port already in use**: If port 8080 is taken, try `-p 8081:80` instead
2. **Wrong file name**: Docker uses `dockerfile` (no extension) by default; if you name it `Dockerfile.txt` it won't work
3. **Forgetting to rebuild**: If you change `index.html`, run `docker build -t nginx-server .` again before starting a new container
4. **Using HTTP instead of HTTPS**: Nginx serves HTTP by default on port 80; don't try https://localhost

## Best Practices

1. **Use specific tags**: Instead of `nginx:latest`, use `nginx:alpine` or `nginx:1.25-alpine` for reproducible builds
2. **Keep HTML minimal**: For a static server, only include the files Nginx needs to serve
3. **Use `.dockerignore`**: Create a `.dockerignore` file to exclude node_modules, .git, and other unnecessary files from the build context

## Success Criteria

- [ ] Container runs without errors
- [ ] `curl http://localhost:8080` returns valid HTML with "Hello from Docker Nginx!"
- [ ] `docker logs` shows Nginx access log entries
- [ ] Container can be stopped and removed cleanly
- [ ] Image builds in under 30 seconds (small base image)
