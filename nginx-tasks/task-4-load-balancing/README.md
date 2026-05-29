# Task 4: Load Balancing (The Juggler)

## Task Overview
Learn how to configure Nginx as a **load balancer** to distribute incoming traffic across multiple backend servers. This is essential for scaling applications horizontally and ensuring high availability.

## Key Concepts
- **Upstream Block**: Defines a group of backend servers that Nginx can distribute requests to
- **Round-Robin (default)**: Distributes requests evenly across all servers in rotation
- **Least Connections (`least_conn`)**: Sends traffic to the server with the fewest active connections
- **IP Hash (`ip_hash`)**: Routes a client to the same backend server every time (session persistence)
- **Health Checks**: Nginx can detect when a backend server is down and stop sending traffic to it
- **Weight**: Assign different weights to servers to send more/less traffic to specific backends

## Files in This Task

| File | Purpose |
|------|---------|
| `README.md` | This file — explains the task |
| `nginx.conf` | Load balancer configuration with upstream block |
| `dockerfile` | Docker image for Nginx load balancer |
| `docker-compose.yaml` | Spins up Nginx + 3 backend server instances |
| `backend/server.js` | Simple Express server that returns its own hostname/port |
| `backend/package.json` | Node.js dependencies for the backend |
| `backend/dockerfile` | Docker image for the backend server |

## Step-by-Step Instructions

### 1. Build and Start the Backend Servers
```bash
cd task-4-load-balancing

# Start everything with Docker Compose
docker compose up --build
```

### 2. Observe Load Balancing in Action
Open a terminal and send multiple requests:
```bash
# Run this several times — you'll see different servers responding
curl http://localhost:80

# The response changes between backend1, backend2, backend3
```

### 3. Try Different Load Balancing Algorithms
Edit `nginx.conf` and uncomment different algorithms:
- `least_conn;` — sends traffic to least busy server
- `ip_hash;` — sticky sessions (same client → same server)

Then restart:
```bash
docker compose restart nginx
```

### 4. Simulate a Server Failure
Stop one backend container to see Nginx route around it:
```bash
docker compose stop backend1
# Nginx automatically stops sending traffic to the failed server
```

## Verification Steps

```bash
# Send 10 requests and observe the distribution
for i in $(seq 1 10); do curl -s http://localhost:80 && echo; done

# Check response headers for the backend server ID
curl -I http://localhost:80

# Verify all backends are registered in the upstream
docker compose logs nginx

# Check that stopping a backend doesn't break the service
docker compose stop backend1
curl http://localhost:80   # Should still work
```

## Common Mistakes

| Mistake | What Happens | How to Fix |
|---------|-------------|------------|
| Wrong backend port in upstream | 502 Bad Gateway | Verify each backend exposes the correct port |
| No health checks configured | Nginx sends traffic to dead servers | Add `max_fails=3 fail_timeout=30s` to server directive |
| Missing `proxy_set_header` | Backend apps see wrong client IP | Always forward `X-Real-IP` and `X-Forwarded-For` headers |
| All backends on same port in compose | Port conflicts on host | Use different host ports (3001, 3002, 3003) mapped to same container port (3000) |

## Best Practices
1. **Always configure at least 3 backend servers** for proper high availability
2. **Use `least_conn`** for applications with uneven request processing times
3. **Set appropriate timeouts** (`proxy_connect_timeout`, `proxy_read_timeout`) to avoid hanging connections
4. **Monitor backend health** with Nginx Plus or external monitoring tools

## Success Criteria
- [ ] All backend servers respond correctly when accessed directly
- [ ] Nginx distributes requests across all backends in round-robin fashion
- [ ] Stopping one backend does not break the service
- [ ] Response headers show which backend served the request
- [ ] Load balancing algorithm can be changed by editing nginx.conf
