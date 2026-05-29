# Task 9: The Networker - Custom Networks

## Task Overview
Learn how to create and use **custom Docker networks** to isolate and connect containers. By default, containers on the same custom network can communicate using service names as DNS hostnames.

## Key Concepts
- **Bridge Network**: Default network driver; containers can communicate via IP
- **Custom Bridge Network**: Provides automatic DNS resolution using container names
- **Network Isolation**: Containers on different networks cannot communicate unless explicitly connected
- **DNS Resolution**: Custom networks resolve container/service names to IP addresses
- **Network Drivers**: bridge, host, overlay (Swarm), macvlan, none

## Files in This Task

| File | Purpose |
|------|---------|
| `docker-compose.yaml` | Defines two services on a custom network |
| `README.md` | Instructions and concepts |

## Step-by-Step Instructions

### 1. Start the services
```bash
cd docker-tasks/task-9-custom-networks
docker compose up --build
```

### 2. Verify they can communicate
```bash
# Exec into the web container and ping the db container
docker exec -it task-9-custom-networks-web-1 ping db

# Check DNS resolution
docker exec -it task-9-custom-networks-web-1 nslookup db
```

### 3. Inspect the network
```bash
docker network ls
docker network inspect task-9-custom-networks_app-net
```

## Verification Steps
- [ ] Web container can ping db container by name
- [ ] `docker network ls` shows the custom network
- [ ] Containers on different networks cannot communicate

## Success Criteria
- [ ] Custom network is created automatically by Docker Compose
- [ ] Service-to-service communication works via DNS names
- [ ] Network isolation is understood
