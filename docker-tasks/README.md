# Docker Tasks Repository

A complete hands-on curriculum of **17 Docker tasks** covering everything from basic containerization to swarm orchestration. Each task builds on the previous one, progressing from simple concepts to production-grade patterns.

---

## Task Progression

### Phase 1: Building & Running Containers (Tasks 1-2)

| # | Task | Folder | What You'll Learn |
|---|------|--------|-------------------|
| 1 | **Node.js App** | `task-1-nodejs-app/` | Dockerfile basics, non-root user security, Alpine images, port exposure |
| 2 | **FastAPI App** | `task-2-fastapi-app/` | Python containerization, dependency management, Uvicorn server |

### Phase 2: Multi-Stage & Multi-Container (Tasks 3-5)

| # | Task | Folder | What You'll Learn |
|---|------|--------|-------------------|
| 3 | **Compose Orchestration** | `task-3-compose-orchestration/` | Docker Compose, multi-service apps, depends_on, custom networking |
| 4 | **Vite + React + Nginx** | `task-4-vite-multistage/` | Multi-stage builds, Vite bundling, Nginx static serving, SPA routing |
| 5 | **CRA + Nginx** | `task-5-cra-multistage/` | Create React App multi-stage build, production optimization |

### Phase 3: Core Docker Patterns (Tasks 6-11)

| # | Task | Folder | What You'll Learn |
|---|------|--------|-------------------|
| 6 | **Nginx Server** | `task-6-nginx-server/` | FROM pre-built images, COPY files, port mapping, detached mode |
| 7 | **Ephemeral FS** | `task-7-ephemeral-fs/` | Container filesystem lifecycle, why volumes are needed |
| 8 | **Named Volumes** | `task-8-named-volumes/` | Docker named volumes, data persistence across restarts |
| 9 | **Custom Networks** | `task-9-custom-networks/` | Network isolation, multi-network containers, DNS resolution |
| 10 | **Bind Mounts** | `task-10-bind-mounts/` | Host-to-container bind mounts, live code reload for development |
| 11 | **Persistent DB** | `task-11-persistent-volumes/` | PostgreSQL with named volumes, database data persistence |

### Phase 4: Production & Operations (Tasks 12-17)

| # | Task | Folder | What You'll Learn |
|---|------|--------|-------------------|
| 12 | **Health Checks** | `task-12-health-checks/` | HEALTHCHECK instruction, health status monitoring, unhealthy detection |
| 13 | **Resource Limits** | `task-13-resource-limits/` | CPU/memory limits, OOM handling, docker stats, stress testing |
| 14 | **Logging** | `task-14-logging/` | Logging drivers, log rotation, structured logging, docker logs |
| 15 | **Multi-Arch Builds** | `task-15-multi-arch-builds/` | buildx, QEMU, multi-platform images, amd64 + arm64 |
| 16 | **Image Registry** | `task-16-image-registry/` | Private registry, tag/push/pull workflow, registry API |
| 17 | **Docker Swarm** | `task-17-docker-swarm/` | Swarm init, stack deploy, scaling, rolling updates |

---

## How to Run Each Task

### Phase 1: Building & Running Containers

```bash
# Task 1: Node.js App
cd task-1-nodejs-app
docker build -t node-app .
docker run -p 3000:3000 node-app

# Task 2: Python FastAPI
cd task-2-fastapi-app
docker build -t fastapi-app .
docker run -p 8000:8000 fastapi-app
```

### Phase 2: Multi-Stage & Multi-Container

```bash
# Task 3: Docker Compose
cd task-3-compose-orchestration
docker compose up --build

# Task 4: Vite + React + Nginx
cd task-4-vite-multistage
docker build -t vite-react-app .
docker run -p 80:80 vite-react-app

# Task 5: Create React App + Nginx
cd task-5-cra-multistage
docker build -t cra-react-app .
docker run -p 80:80 cra-react-app
```

### Phase 3: Core Docker Patterns

```bash
# Task 6: Basic Nginx Server
cd task-6-nginx-server
docker build -t nginx-server .
docker run -d -p 8080:80 --name my-nginx nginx-server
curl http://localhost:8080

# Task 7: Ephemeral Filesystem
cd task-7-ephemeral-fs
docker compose up --build
docker compose up  # Run again - see data disappear!

# Task 8: Named Volumes
cd task-8-named-volumes
docker compose up --build
docker compose up  # Run again - data persists!

# Task 9: Custom Networks
cd task-9-custom-networks
docker compose up --build -d
curl http://localhost:5000
docker compose exec api ping -c 2 db

# Task 10: Bind Mounts (Live Edit)
cd task-10-bind-mounts
docker compose up --build
# Edit app.js and refresh - changes appear instantly!

# Task 11: PostgreSQL Named Volume
cd task-11-persistent-volumes
docker compose up -d
docker exec -it pg-demo psql -U appuser -d appdb
```

### Phase 4: Production & Operations

```bash
# Task 12: Health Checks
cd task-12-health-checks
docker compose up --build -d
docker ps  # See (healthy) status
curl http://localhost:5000/set-unhealthy
docker inspect task-12-healthchecks --format '{{json .State.Health.Status}}'

# Task 13: Resource Limits
cd task-13-resource-limits
docker compose up --build -d
docker stats
docker exec -it task-13-resource-limits python /stress.py --memory 500

# Task 14: Logging
cd task-14-logging
docker compose up --build -d
docker compose logs -f json-logger
docker compose logs --tail 20 local-logger

# Task 15: Multi-Arch Builds
cd task-15-multi-arch-builds
docker buildx create --name multiarch-builder --use
docker buildx build --platform linux/amd64,linux/arm64 -t yourname/multiarch-demo:latest .

# Task 16: Image Registry
cd task-16-image-registry
docker compose up -d registry
docker build -t localhost:5000/my-alatest .
docker push localhost:5000/my-alatest
curl http://localhost:5000/v2/_catalog

# Task 17: Docker Swarm
cd task-17-docker-swarm
docker swarm init
docker build -t swarm-app .
docker stack deploy -c docker-stack.yaml swarm-demo
docker stack services swarm-demo
curl http://localhost:8080
docker service scale swarm-demo_web=5
docker stack rm swarm-demo
docker swarm leave --force
```

---

## Key Concepts Covered

### 1. **Container Fundamentals**
- Dockerfile syntax and best practices
- Image layers and caching
- Alpine Linux for minimal images
- Port mapping and exposure

### 2. **Security Best Practices**
- Non-root user execution
- Minimal base images
- Proper file permissions
- Read-only filesystems

### 3. **Data Persistence**
- Ephemeral container filesystem
- Named volumes for databases
- Bind mounts for development
- Volume lifecycle management

### 4. **Networking**
- Multi-container communication
- Custom networks for isolation
- DNS resolution between services
- Overlay networks in Swarm

### 5. **Multi-Stage Builds**
- Build vs runtime separation
- Reduced final image size
- Build tool optimization
- Layer caching strategies

### 6. **Production Operations**
- Health checks and monitoring
- Resource limits and constraints
- Logging drivers and rotation
- Private image registries

### 7. **Orchestration**
- Docker Compose for local dev
- Docker Swarm for clustering
- Service scaling and updates
- Resource management

---

## Bonus: Learning Path

Follow this order for the best learning experience:

1. **Tasks 1-2**: Learn Dockerfile basics with Node.js and Python
2. **Tasks 3-5**: Understand multi-container and multi-stage builds
3. **Tasks 6-7**: Master simple web servers and ephemeral storage
4. **Tasks 8-11**: Data persistence with volumes, networks, and bind mounts
5. **Tasks 12-13**: Production readiness with health checks and resource limits
6. **Tasks 14-16**: Operations skills - logging, multi-arch, registries
7. **Task 17**: Orchestration with Docker Swarm

---

## Directory Structure

```
docker-tasks/
  README.md                    # This file
  task-1-nodejs-app/           # Node.js with security best practices
  task-2-fastapi-app/          # Python FastAPI with Uvicorn
  task-3-compose-orchestration/ # Multi-container with Docker Compose
  task-4-vite-multistage/      # Vite + React + Nginx multi-stage
  task-5-cra-multistage/       # CRA + Nginx multi-stage
  task-6-nginx-server/         # Basic Nginx static server
  task-7-ephemeral-fs/         # Ephemeral filesystem demo
  task-8-named-volumes/        # Named volume persistence
  task-9-custom-networks/      # Network isolation demo
  task-10-bind-mounts/         # Live code reload with bind mounts
  task-11-persistent-volumes/  # PostgreSQL with named volumes
  task-12-health-checks/       # Docker HEALTHCHECK instruction
  task-13-resource-limits/     # CPU/memory limits demo
  task-14-logging/             # Logging drivers and management
  task-15-multi-arch-builds/   # Multi-platform builds with buildx
  task-16-image-registry/      # Local private Docker registry
  task-17-docker-swarm/        # Swarm orchestration demo
```
