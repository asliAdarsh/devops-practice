# Task 3: Multi-Container Application with Docker Compose

This task demonstrates how to orchestrate multiple containers using Docker Compose with a Node.js web application and Redis database.

## Overview

- **Web Service:** Node.js application that connects to Redis
- **Database Service:** Redis cache
- **Orchestration:** Docker Compose
- **Networking:** Custom bridge network

## Architecture

```
┌─────────────┐    ┌─────────────┐
│   Web App   │────│   Redis     │
│  (Node.js)  │    │  Database   │
│   Port 3000 │    │   Port 6379 │
└─────────────┘    └─────────────┘
     │                    │
     └───── Network ───────┘
```

## Files

- `index.js` - Node.js application with Redis connection
- `package.json` - Node.js dependencies
- `dockerfile` - Web application container configuration
- `docker-compose.yaml` - Multi-container orchestration

## How to Run

### Using Docker Compose (Recommended)
```bash
# Build and start all services
docker-compose up --build

# Run in detached mode
docker-compose up --build -d
```

### View Logs
```bash
# Follow logs for all services
docker-compose logs -f

# View logs for specific service
docker-compose logs -f web
docker-compose logs -f db
```

### Stop Services
```bash
# Stop and remove containers
docker-compose down

# Stop and remove with volumes
docker-compose down -v
```

## Access the Application

- **Web Application:** `http://localhost:3000`
- **Redis:** Accessible from web container at `db:6379`

## Development

### Install Dependencies Locally
```bash
npm install
```

### Run Locally (with Redis required)
```bash
# Start Redis locally (if not using Docker)
redis-server

# Set environment variables
export REDIS_HOST=localhost
export REDIS_PORT=6379

# Start the application
npm start
```

## Docker Compose Features Demonstrated

1. **Service Dependencies:** `web` depends on `db`
2. **Custom Networks:** Isolated communication between services
3. **Environment Variables:** Configuration for service communication
4. **Port Mapping:** Expose services to host
5. **Build Context:** Automatic image building

## Troubleshooting

### Check Service Status
```bash
docker-compose ps
```

### Inspect Network
```bash
docker network ls
docker network inspect docker-tasks_node-net
```

### Connect to Running Container
```bash
docker-compose exec web sh
docker-compose exec db redis-cli
```

## Clean Up

Remove all containers, networks, and images:
```bash
docker-compose down --rmi all
```
