# Task 8: Performance Caching (The Accelerator)

## Task Overview
Learn how to use Nginx as a **caching reverse proxy** to speed up your website and reduce load on backend servers. Nginx can cache responses from backend servers and serve them directly to clients, dramatically improving performance.

## Key Concepts
- **`proxy_cache_path`**: Defines a cache storage location, size limits, and expiration policies
- **`proxy_cache`**: Enables caching for a specific location
- **`proxy_cache_key`**: Defines what makes a cache entry unique (by default: scheme + host + URI)
- **`proxy_cache_valid`**: Sets how long to cache responses based on status codes
- **`Cache-Control` headers**: Backend can tell Nginx how long to cache via `X-Accel-Expires` or standard `Cache-Control` headers
- **`proxy_cache_bypass`**: Conditions that bypass the cache (e.g., cookies, specific query params)
- **`proxy_no_cache`**: Conditions that prevent caching of certain responses
- **Cache Purging**: Removing cached items (requires Nginx Plus or a custom module)
- **`gzip` on**: Compresses responses before sending to clients for faster transfer

## Files in This Task

| File | Purpose |
|------|---------|
| `README.md` | This file — explains the task |
| `nginx.conf` | Nginx config with proxy caching and gzip |
| `dockerfile` | Docker image for Nginx with caching |
| `docker-compose.yaml` | Spins up Nginx + backend with caching |
| `backend/server.js` | Express server that shows cache behavior with timestamps |
| `backend/package.json` | Node.js dependencies |
| `backend/dockerfile` | Docker image for backend |

## Step-by-Step Instructions

### 1. Start the Services
```bash
cd task-8-performance-caching
docker compose up --build
```

### 2. Observe Caching in Action
```bash
# First request — hits the backend (slow, takes ~1 second due to artificial delay)
curl http://localhost:80
# Response includes "X-Cache: MISS" header

# Second request — served from cache (instant)
curl http://localhost:80
# Response includes "X-Cache: HIT" header

# Notice the timestamp doesn't change on cache hits
```

### 3. Bypass the Cache
```bash
# Request with a unique query parameter — bypasses cache
curl "http://localhost:80?nocache=true"
# Or use a refresh header
curl -H "Cache-Control: no-cache" http://localhost:80
```

### 4. Check Cache Statistics
```bash
# Check the cache status via the /cache-status endpoint
curl http://localhost:80/cache-status
```

### 5. Test Gzip Compression
```bash
# Without compression
curl http://localhost:80

# With compression (accept gzip)
curl -H "Accept-Encoding: gzip" http://localhost:80 -o /dev/null -w "Size: %{size_download}\n"
```

## Verification Steps

```bash
# Check cache headers
curl -I http://localhost:80

# Verify X-Cache shows HIT vs MISS
for i in $(seq 1 5); do
  curl -sI http://localhost:80 | grep -i "x-cache"
done

# Check that cached responses expire
# Wait for cache_valid time or modify nginx.conf

# Verify gzip is working
curl -H "Accept-Encoding: gzip" -sI http://localhost:80 | grep -i "content-encoding"
```

## Common Mistakes

| Mistake | What Happens | How to Fix |
|---------|-------------|------------|
| Cache path directory doesn't exist | Nginx fails to start | Create the cache directory or use absolute path |
| No `keys_zone` defined | Cache runs out of index entries | Always define `keys_zone` with sufficient size |
| Caching dynamic content (e.g., user profiles) | Users see stale data | Use `proxy_cache_bypass` for authenticated requests |
| Forgetting `proxy_cache_key` customization | Different users see same cached page | Include `$http_cookie` or user ID in cache key |
| Too long `cache_valid` | Stale content served for too long | Set realistic TTLs based on content type (1m-1h) |
| Gzip on proxied content without `gzip_proxied` | Backend responses not compressed | Set `gzip_proxied any;` |

## Best Practices
1. **Cache static assets aggressively** (images, CSS, JS) — set `proxy_cache_valid 200 30d;`
2. **Cache API responses selectively** — short TTLs (1-5 minutes) for dynamic endpoints
3. **Use `X-Cache` headers during development** to verify caching behavior
4. **Set `proxy_cache_lock on`** to prevent multiple requests for the same uncached resource (cache stampede)
5. **Always purge relevant cached items** when deploying new content
6. **Enable gzip** to reduce bandwidth by 60-80% for text-based responses

## Success Criteria
- [ ] First request to a URL results in `X-Cache: MISS`
- [ ] Subsequent requests to same URL result in `X-Cache: HIT`
- [ ] Cached responses are returned instantly (no backend delay)
- [ ] Cache can be bypassed with query parameters or headers
- [ ] Gzip compression reduces response size
- [ ] Cache respects TTL and re-fetches from backend when expired
