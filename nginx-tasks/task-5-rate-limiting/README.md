# Task 5: Rate Limiting (The Bouncer)

## Task Overview
Learn how to configure Nginx **rate limiting** to protect your backend servers from being overwhelmed by too many requests. Rate limiting prevents abuse, DDoS attacks, and ensures fair resource usage.

## Key Concepts
- **`limit_req_zone`**: Defines a shared memory zone that tracks request rates (defined in `http` block)
- **`limit_req`**: Applies rate limiting to a specific `location` block
- **Rate**: Maximum number of requests allowed per second (e.g., `1r/s` = 1 request per second)
- **Burst**: A queue that allows temporary bursts above the limit
- **Nodelay**: Processes burst requests immediately instead of spacing them out
- **`limit_req_status`**: Custom HTTP status code when rate limit is exceeded (default: 503)
- **Dry Run (`dry_run`)**: Test rate limiting rules without actually blocking requests

## Files in This Task

| File | Purpose |
|------|---------|
| `README.md` | This file — explains the task |
| `nginx.conf` | Nginx configuration with rate limiting zones |
| `dockerfile` | Docker image for Nginx with rate limiting |
| `docker-compose.yaml` | Spins up Nginx + backend |
| `backend/server.js` | Simple Express server to test against |
| `backend/package.json` | Node.js dependencies |
| `backend/dockerfile` | Docker image for backend |
| `test.sh` | Script to demonstrate rate limiting in action |

## Step-by-Step Instructions

### 1. Start the Services
```bash
cd task-5-rate-limiting
docker compose up --build
```

### 2. Test Normal Request Rate
```bash
# Send requests slowly — all should succeed
curl http://localhost:80
sleep 1
curl http://localhost:80
```

### 3. Trigger Rate Limiting
```bash
# Send requests rapidly — you'll see 503 Service Unavailable
for i in $(seq 1 10); do
  curl -s -w "\nHTTP Status: %{http_code}\n" http://localhost:80
done
```

### 4. Test with Burst
Edit `nginx.conf` and uncomment the burst line, then restart:
```bash
docker compose restart nginx

# Now rapid requests get queued instead of rejected
for i in $(seq 1 10); do
  curl -s -w "\nHTTP Status: %{http_code}\n" http://localhost:80
done
```

### 5. Run the Test Script
```bash
# The test script shows the difference with and without rate limiting
chmod +x test.sh
./test.sh
```

## Verification Steps

```bash
# Check that normal requests work (200 OK)
curl -I http://localhost:80

# Trigger rate limiting and check the status code
for i in $(seq 1 5); do curl -s -o /dev/null -w "%{http_code}\n" http://localhost:80 & done; wait

# Check rate limit headers (Nginx adds X-RateLimit headers in some configs)
curl -v http://localhost:80 2>&1 | grep -i "rate"

# View rate limiting logs
docker compose logs nginx
```

## Common Mistakes

| Mistake | What Happens | How to Fix |
|---------|-------------|------------|
| Zone defined in `server` block | Nginx won't start | `limit_req_zone` must be in the `http` block |
| Forgetting `burst` | Legitimate traffic spikes get rejected | Always add `burst=nodelay` for production |
| Too low a rate (e.g., `1r/m`) | All requests get limited | Start with `10r/s` and adjust based on monitoring |
| Rate limiting `/` instead of `/api/` | Static assets also get limited | Apply rate limiting only to API endpoints |

## Best Practices
1. **Use `burst` and `nodelay` together** for smooth traffic handling
2. **Apply rate limiting at the location level** — protect specific endpoints, not everything
3. **Monitor `limit_req` logs** to fine-tune your rate limits over time
4. **Return a meaningful response** with `limit_req_status 429` (Too Many Requests) instead of the default 503
5. **Test with `dry_run` mode first** to see how many requests would be limited without impacting real users

## Success Criteria
- [ ] Normal request rate succeeds with 200 OK
- [ ] Rapid requests trigger 503 (or 429) status code
- [ ] Burst allows short traffic spikes without errors
- [ ] Rate limit zone uses shared memory (`$binary_remote_addr`)
- [ ] Rate limiting can be bypassed or tuned by editing nginx.conf
