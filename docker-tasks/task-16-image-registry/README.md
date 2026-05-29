# Task 16: The Publisher - Image Registry

## Task Overview

Learn how to run a **private Docker registry** locally and push/pull images to it. Private registries are essential for teams that need to store and distribute images without relying on public registries like Docker Hub.

## Key Concepts

- **Docker Registry**: A storage and distribution system for Docker images (the `registry:2` image)
- **Tagging**: Images are tagged with the registry address (e.g., `localhost:5000/myapp:latest`)
- **Push/Pull workflow**: Build an image, tag it with the registry URL, push to registry, pull from elsewhere
- **Local registry**: Running a registry on your own infrastructure for private image storage
- **HTTPS requirement**: Docker requires HTTPS for registries (except localhost)
- **Registry storage**: By default, the registry stores images in a Docker volume

## Files in This Task

| File | Purpose |
|------|---------|
| `docker-compose.yaml` | Defines the registry service and a sample app |
| `dockerfile` | Simple app to build and push to the local registry |
| `index.html` | A static page for the sample image |
| `README.md` | Instructions and concepts |

## Step-by-Step Instructions

### Step 1: Start the local registry

```bash
cd docker-tasks/task-16-image-registry
docker compose up -d registry
```

### Step 2: Verify the registry is running

```bash
docker ps
curl http://localhost:5000/v2/  # Should return {}
```

### Step 3: Build and tag a sample image

```bash
# Build the sample app
docker build -t localhost:5000/my-alatest .

# Or use docker compose
docker compose build sample-app
```

### Step 4: Push the image to the local registry

```bash
docker push localhost:5000/my-alatest
```

### Step 5: Pull from the local registry

First, remove the local image:

```bash
docker rmi localhost:5000/my-alatest
```

Now pull from the registry:

```bash
docker pull localhost:5000/my-alatest
```

### Step 6: List images in the registry

```bash
# List repositories
curl http://localhost:5000/v2/_catalog

# List tags for a repository
curl http://localhost:5000/v2/my-app/tags/list
```

### Step 7: Clean up

```bash
docker compose down
docker volume rm task-16-image-registry_registry_data
```

## Verification Steps

1. `curl http://localhost:5000/v2/` returns `{}`
2. `curl http://localhost:5000/v2/_catalog` shows your repository
3. `docker push` succeeds without errors
4. `docker pull` retrieves the image after deletion
5. Registry container logs show push/pull activity

## Common Mistakes

1. **Missing tag prefix**: Images must be tagged with `localhost:5000/` prefix to push to local registry
2. **Pushing without tagging first**: You can't push `my-app:latest` to localhost:5000; it must be tagged
3. **HTTPS errors on non-localhost registries**: Remote registries require HTTPS; use `--insecure-registry` in Docker daemon config for testing
4. **Registry data not persisted**: Without a volume, restarting the registry loses all images
5. **Running out of disk space**: The local registry stores all pushed images; prune unused images periodically

## Best Practices

1. **Always persist registry data**: Mount a volume for `/var/lib/registry`
2. **Set up authentication**: Use htpasswd-based auth for non-local registries
3. **Enable garbage collection**: Run periodic garbage collection to reclaim storage: `docker exec registry registry garbage-collect /etc/docker/registry/config.yml`
4. **Use TLS/HTTPS in production**: Never run a production registry without HTTPS
5. **Tag images meaningfully**: Use semantic versioning (e.g., `my-app:1.2.3`) alongside `latest`

## Success Criteria

- [ ] Registry container starts and responds on port 5000
- [ ] `curl http://localhost:5000/v2/` returns `{}`
- [ ] `docker push localhost:5000/my-alatest` succeeds
- [ ] `docker pull localhost:5000/my-alatest` retrieves the image
- [ ] `curl http://localhost:5000/v2/_catalog` shows the pushed repository
- [ ] Registry data persists across restarts (via volume)
