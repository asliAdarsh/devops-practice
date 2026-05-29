# Task 17: The Swarm Master - Docker Swarm

## Task Overview

Learn the basics of **Docker Swarm** - Docker's built-in container orchestration tool. You'll initialize a single-node swarm, deploy a stack, scale services, and perform rolling updates.

## Key Concepts

- **Swarm mode**: A cluster of Docker engines working together as a single virtual host
- **Manager and worker nodes**: Managers handle cluster management; workers run containers
- **Stack**: A group of services defined in a Compose file deployed to the swarm
- **Services**: Declarative definition of how to run containers across the swarm
- **Replicas**: Multiple instances of the same service for high availability and load balancing
- **Rolling updates**: Update services without downtime by updating replicas gradually
- **Overlay network**: Multi-host network that spans all swarm nodes

## Files in This Task

| File | Purpose |
|------|---------|
| `docker-stack.yaml` | Swarm-compatible stack file defining a web service |
| `dockerfile` | Builds the web app image |
| `app.py` | Simple Python web app that displays hostname and node info |
| `requirements.txt` | Python dependencies |
| `README.md` | Instructions and concepts |

## Step-by-Step Instructions

### Step 1: Initialize the swarm

```bash
docker swarm init
```

### Step 2: Build the app image

```bash
cd docker-tasks/task-17-docker-swarm
docker build -t swarm-app .
```

### Step 3: Deploy the stack

```bash
docker stack deploy -c docker-stack.yaml swarm-demo
```

### Step 4: Verify the stack

```bash
# List stacks
docker stack ls

# List services in the stack
docker stack services swarm-demo

# List tasks (containers) for a service
docker stack ps swarm-demo

# List all containers in the swarm
docker service ps swarm-demo_web
```

### Step 5: Test the web app

```bash
# Find which node the service is running on
docker service ps swarm-demo_web

# Access the app
curl http://localhost:8080
```

### Step 6: Scale the service

```bash
docker service scale swarm-demo_web=5

# Verify scaling
docker service ls
docker service ps swarm-demo_web
```

### Step 7: Perform a rolling update

First, make a change to the app (e.g., change the message in app.py). Then rebuild and update:

```bash
docker build -t swarm-app .
docker service update swarm-demo_web --image swarm-app
```

### Step 8: Inspect the service

```bash
docker service inspect swarm-demo_web --pretty
docker service logs swarm-demo_web
```

### Step 9: Clean up

```bash
docker stack rm swarm-demo
docker swarm leave --force
```

## Verification Steps

1. `docker swarm init` completes successfully
2. `docker stack deploy` creates the services
3. `docker stack services` shows the web service with replicas
4. `curl http://localhost:8080` returns the web app response
5. Scaling to 5 replicas creates 5 containers
6. Rolling update works without downtime
7. `docker stack rm` removes all resources

## Common Mistakes

1. **Port already in use on swarm init**: Swarm uses port 2377 for cluster management; ensure it's available
2. **Missing image tag**: Swarm services need explicitly tagged images; `latest` may cause issues
3. **Using volumes without `--mount` in Swarm**: Bind mounts work differently in Swarm; use named volumes or `--mount type=bind`
4. **Not rebuilding after code changes**: The image must be rebuilt and re-tagged before `service update` sees it
5. **Forgetting `docker stack rm`**: Stacks persist after the session; clean up to free resources

## Best Practices

1. **Use pinned image tags**: Always use specific versions (e.g., `swarm-alatest`) instead of `latest`
2. **Set update order**: `--update-order start-first` starts new containers before stopping old ones for zero-downtime
3. **Add health checks**: Swarm uses health checks to decide when to restart containers
4. **Set resource limits**: Swarm respects resource limits for scheduling
5. **Use secrets for sensitive data**: Docker Swarm has built-in secrets management

## Success Criteria

- [ ] `docker swarm init` initializes the swarm
- [ ] `docker stack deploy` creates the service
- [ ] `docker stack services` lists the web service
- [ ] `curl http://localhost:8080` returns the app response
- [ ] Service can be scaled to multiple replicas
- [ ] Rolling update works without errors
- [ ] `docker stack rm` cleans up all resources
