# Nginx Tasks

![Nginx](https://img.shields.io/badge/Nginx-Tasks-009639?style=flat-square&logo=nginx&logoColor=white)

This directory contains **11 hands-on exercises** with **Nginx** — progressing from basic static serving to advanced production-grade configurations. Each task builds on the previous one, forming a complete Nginx learning path from Level 0 to DevOps-ready.

---

## Learning Path: Level 0 → DevOps

| Level | Task | What You'll Learn | Theme |
|-------|------|-------------------|-------|
| 🟢 Level 0 | [Task 1: Static Content](#task-1-static-content-the-doorman) | Basic Nginx, serving HTML, Docker | The Doorman |
| 🟢 Level 0 | [Task 2: Reverse Proxy](#task-2-reverse-proxy-the-forwarder) | proxy_pass, headers, Node.js backend | The Forwarder |
| 🟢 Level 0 | [Task 3: SPA Fallback](#task-3-spa-fallback-the-react-fixer) | try_files, React Router, SPA deployment | The React Fixer |
| 🟡 Level 1 | [Task 4: Load Balancing](#task-4-load-balancing-the-juggler) | upstream, round-robin, least_conn | The Juggler |
| 🟡 Level 1 | [Task 5: Rate Limiting](#task-5-rate-limiting-the-bouncer) | limit_req_zone, burst, nodelay | The Bouncer |
| 🟡 Level 1 | [Task 6: Access Control](#task-6-access-control-the-spy) | allow/deny, auth_basic, .htpasswd | The Spy |
| 🟠 Level 2 | [Task 7: Security Headers](#task-7-security-headers-the-hardened-shell) | X-Frame-Options, CSP, HSTS | The Hardened Shell |
| 🟠 Level 2 | [Task 8: Performance Caching](#task-8-performance-caching-the-accelerator) | proxy_cache, gzip, cache zones | The Accelerator |
| 🟠 Level 2 | [Task 9: SSL/HTTPS](#task-9-ssl-https-the-encryptor) | SSL certs, TLS, HTTP→HTTPS redirect | The Encryptor |
| 🔵 Level 3 | [Task 10: JSON Logging](#task-10-json-logging-the-data-miner) | log_format, access_log, structured logging | The Data Miner |
| 🔵 Level 3 | [Task 11: URL Rewriting](#task-11-url-rewriting-the-masquerade) | rewrite, return, try_files, regex | The Masquerade |

---

## Task 1: Static Content (The Doorman)

**Folder:** `task-1-static-content/`

**What I Practiced:**
- Serving a simple HTML page using Nginx inside a Docker container
- Building a custom Nginx image with `nginx:alpine` base
- Copying static assets to Nginx's default web root (`/usr/share/nginx/html`)
- Exposing port 80 for HTTP traffic

**Files:**
| File | Purpose |
|------|---------|
| `dockerfile` | Custom Nginx image with static HTML |
| `index.html` | Simple interactive page with button click counter |

**Run it:**
```bash
cd task-1-static-content
docker build -t nginx-static .
docker run -p 80:80 nginx-static
```

---

## Task 2: Reverse Proxy (The Forwarder)

**Folder:** `task-2-reverse-proxy/`

**What I Practiced:**
- Configuring Nginx as a **reverse proxy** in front of a Node.js Express app
- Setting up `proxy_pass` to forward requests to the backend
- Passing client headers (`Host`, `X-Real-IP`) to the proxied application
- Using `events {}` and `http {}` block configuration

**Files:**
| File | Purpose |
|------|---------|
| `dockerfile` | Docker image for the Express.js app |
| `nginx.conf` | Nginx reverse proxy configuration |
| `index.js` | Express.js app with `/` and `/admin` routes |
| `package.json` | Node.js dependencies |

**Run it:**
```bash
cd task-2-reverse-proxy
docker build -t node-backend .
docker run -d -p 3000:3000 --name backend node-backend
# Then run nginx container that proxies to the backend
```

---

## Task 3: SPA Fallback (The React Fixer)

**Folder:** `task-3-spa-fallback/`

**What I Practiced:**
- Building a **React** application with client-side routing (Home, About, Contact pages)
- Creating a production build using Create React App
- Serving the built React app with Nginx
- Configuring SPA fallback routing with `try_files`
- Setting up a complete Docker + Nginx production deployment pipeline

**Files:**
| File | Purpose |
|------|---------|
| `src/App.js` | React app with React Router (Home, About, Contact) |
| `public/index.html` | HTML template |
| `build/` | Production build output |
| `package.json` | Node.js dependencies |

**Run it:**
```bash
cd task-3-spa-fallback
# Build the React app
npm run build
# Then serve with Nginx (either with Docker or directly)
```

---

## Task 4: Load Balancing (The Juggler)

**Folder:** `task-4-load-balancing/`

**What I Practiced:**
- Configuring an `upstream` block with multiple backend servers
- Load balancing algorithms: round-robin, `least_conn`, `ip_hash`
- Weighted server distribution
- Passive health checks with `max_fails` and `fail_timeout`
- Horizontal scaling with 3 backend instances

**Files:**
| File | Purpose |
|------|---------|
| `nginx.conf` | Upstream block with 3 servers, weighted |
| `docker-compose.yaml` | Nginx + 3 backend server instances |
| `dockerfile` | Docker image for Nginx load balancer |
| `backend/server.js` | Express server returning hostname |
| `backend/dockerfile` | Docker image for backend |
| `backend/package.json` | Node.js dependencies |

**Run it:**
```bash
cd task-4-load-balancing
docker compose up --build
# Test: curl http://localhost:80 (see different backends respond)
```

---

## Task 5: Rate Limiting (The Bouncer)

**Folder:** `task-5-rate-limiting/`

**What I Practiced:**
- Defining rate limit zones with `limit_req_zone`
- Applying rate limits to specific locations
- Using `burst` and `nodelay` for traffic spikes
- Custom status codes with `limit_req_status`
- Testing rate limiting behavior with a Bash script

**Files:**
| File | Purpose |
|------|---------|
| `nginx.conf` | Rate limiting zones and location config |
| `docker-compose.yaml` | Nginx + backend |
| `test.sh` | Script to demonstrate rate limiting |
| `backend/server.js` | Express server for testing |
| `backend/dockerfile` | Docker image for backend |
| `backend/package.json` | Node.js dependencies |

**Run it:**
```bash
cd task-5-rate-limiting
docker compose up --build
# Test: for i in $(seq 1 10); do curl -s -w "\nHTTP: %{http_code}\n" http://localhost:80; done
```

---

## Task 6: Access Control (The Spy)

**Folder:** `task-6-access-control/`

**What I Practiced:**
- IP-based access control with `allow`/`deny` directives
- HTTP Basic Authentication with `auth_basic`
- Creating `.htpasswd` files for user credentials
- Using `satisfy any` to combine IP and auth controls
- Layered security for admin endpoints

**Files:**
| File | Purpose |
|------|---------|
| `nginx.conf` | Allow/deny rules + Basic Auth |
| `.htpasswd` | Encrypted credentials for Basic Auth |
| `docker-compose.yaml` | Nginx + backend |
| `dockerfile` | Docker image for Nginx with access control |
| `backend/server.js` | Express server with admin route |
| `backend/dockerfile` | Docker image for backend |
| `backend/package.json` | Node.js dependencies |

**Run it:**
```bash
cd task-6-access-control
docker compose up --build
# Test: curl -u admin:admin123 http://localhost/admin
```

---

## Task 7: Security Headers (The Hardened Shell)

**Folder:** `task-7-security-headers/`

**What I Practiced:**
- Adding security headers: `X-Frame-Options`, `X-Content-Type-Options`, `X-XSS-Protection`
- Configuring Content Security Policy (CSP)
- Setting up HTTP Strict Transport Security (HSTS)
- `Referrer-Policy` and `Permissions-Policy` headers
- Using `add_header` with `always` for error responses
- Hiding Nginx version with `server_tokens off`

**Files:**
| File | Purpose |
|------|---------|
| `nginx.conf` | Comprehensive security headers |
| `docker-compose.yaml` | Nginx + backend |
| `dockerfile` | Docker image for Nginx with security headers |
| `backend/server.js` | Express server |
| `backend/dockerfile` | Docker image for backend |
| `backend/package.json` | Node.js dependencies |

**Run it:**
```bash
cd task-7-security-headers
docker compose up --build
# Test: curl -I http://localhost:80
```

---

## Task 8: Performance Caching (The Accelerator)

**Folder:** `task-8-performance-caching/`

**What I Practiced:**
- Setting up proxy cache zones with `proxy_cache_path`
- Enabling caching with `proxy_cache` and `proxy_cache_valid`
- Cache key customization with `proxy_cache_key`
- Cache bypass strategies with `proxy_cache_bypass`
- Gzip compression for faster transfers
- Cache stampede prevention with `proxy_cache_lock`

**Files:**
| File | Purpose |
|------|---------|
| `nginx.conf` | Cache zones, gzip, cache bypass |
| `docker-compose.yaml` | Nginx + backend |
| `dockerfile` | Docker image for Nginx with caching |
| `backend/server.js` | Express server with artificial delay |
| `backend/dockerfile` | Docker image for backend |
| `backend/package.json` | Node.js dependencies |

**Run it:**
```bash
cd task-8-performance-caching
docker compose up --build
# Test: curl -I http://localhost:80 (watch X-Cache: MISS vs HIT)
```

---

## Task 9: SSL/HTTPS (The Encryptor)

**Folder:** `task-9-ssl-https/`

**What I Practiced:**
- Generating self-signed SSL certificates with OpenSSL
- Configuring `ssl_certificate` and `ssl_certificate_key`
- Setting TLS protocols (`TLSv1.2 TLSv1.3`)
- Strong cipher suite configuration
- HTTP → HTTPS redirect with `return 301`
- HSTS header for enforcing HTTPS
- SSL session caching for performance

**Files:**
| File | Purpose |
|------|---------|
| `nginx.conf` | SSL configuration with HTTPS redirect |
| `generate-certs.sh` | Script to create self-signed certs |
| `certs/` | Directory for SSL certificates |
| `docker-compose.yaml` | Nginx (ports 80+443) + backend |
| `dockerfile` | Docker image for Nginx with SSL |
| `backend/server.js` | Express server |
| `backend/dockerfile` | Docker image for backend |
| `backend/package.json` | Node.js dependencies |

**Run it:**
```bash
cd task-9-ssl-https
chmod +x generate-certs.sh && ./generate-certs.sh
docker compose up --build
# Test: curl -k https://localhost
```

---

## Task 10: JSON Logging (The Data Miner)

**Folder:** `task-10-json-logging/`

**What I Practiced:**
- Creating custom `log_format` with JSON structure
- Using `escape=json` for proper character escaping
- Writing access and error logs in JSON format
- Log buffering for performance (`buffer=32k flush=5s`)
- Parsing JSON logs with `jq`
- Conditional logging strategies

**Files:**
| File | Purpose |
|------|---------|
| `nginx.conf` | JSON log format configuration |
| `docker-compose.yaml` | Nginx with log volume mount |
| `dockerfile` | Docker image for Nginx with JSON logging |

**Run it:**
```bash
cd task-10-json-logging
docker compose up --build
# Generate traffic: curl http://localhost:80
# View logs: docker compose exec nginx cat /var/log/nginx/access.json.log | jq '.'
```

---

## Task 11: URL Rewriting (The Masquerade)

**Folder:** `task-11-url-rewriting/`

**What I Practiced:**
- URL rewriting with `rewrite` directive and regex patterns
- Permanent (301) and temporary (302) redirects with `return`
- Regex captures for dynamic URL parameters
- `try_files` for SPA fallback routing
- SEO-friendly URL structures
- Preventing redirect loops

**Files:**
| File | Purpose |
|------|---------|
| `nginx.conf` | Multiple rewrite examples with comments |
| `docker-compose.yaml` | Nginx standalone |
| `dockerfile` | Docker image with SPA test page |

**Run it:**
```bash
cd task-11-url-rewriting
docker compose up --build
# Test: curl http://localhost/old-page (redirects to /new-page)
# Test: curl http://localhost/products/42 (rewrites to /product?id=42)
```

---

## Nginx Configuration Summary

### Static Server (Task 1)
```nginx
server {
    listen 80;
    root /usr/share/nginx/html;
}
```

### Reverse Proxy (Task 2)
```nginx
server {
    listen 80;
    location / {
        proxy_pass http://backend:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### SPA Routing (Tasks 3 & 11)
```nginx
location / {
    try_files $uri $uri/ /index.html;
}
```

### Load Balancing (Task 4)
```nginx
upstream backend_servers {
    server backend1:3000 weight=3;
    server backend2:3000 weight=2;
    server backend3:3000 weight=1;
}

server {
    location / {
        proxy_pass http://backend_servers;
    }
}
```

### Rate Limiting (Task 5)
```nginx
http {
    limit_req_zone $binary_remote_addr zone=ratelimit:10m rate=1r/s;
    server {
        location / {
            limit_req zone=ratelimit burst=5 nodelay;
        }
    }
}
```

### SSL/HTTPS (Task 9)
```nginx
server {
    listen 443 ssl;
    ssl_certificate /etc/nginx/certs/cert.pem;
    ssl_certificate_key /etc/nginx/certs/key.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
}

server {
    listen 80;
    return 301 https://$host$request_uri;
}
```

### JSON Logging (Task 10)
```nginx
http {
    log_format json escape=json '{ "timestamp":"$time_iso8601", ... }';
    server {
        access_log /var/log/nginx/access.json.log json_log;
    }
}
```

---

## Skills Practiced

- [x] Static file serving with Nginx
- [x] Reverse proxy configuration (proxy_pass, headers)
- [x] Single Page Application fallback routing (try_files)
- [x] Load balancing with upstream blocks (round-robin, least_conn, ip_hash)
- [x] Rate limiting with burst and nodelay
- [x] Access control with IP allow/deny and Basic Auth
- [x] Security headers (CSP, HSTS, X-Frame-Options, etc.)
- [x] Performance caching with proxy_cache and gzip
- [x] SSL/HTTPS configuration with self-signed certs
- [x] JSON-structured logging for log aggregation
- [x] URL rewriting with regex and redirects
- [x] Docker + Nginx integration across all tasks
- [x] Docker Compose for multi-service setups
- [x] Production deployment patterns for web applications

---

## Quick Reference: Run Any Task

| Task | Command |
|------|---------|
| 1. Static Content | `cd task-1-static-content && docker build -t nginx-static . && docker run -p 80:80 nginx-static` |
| 2. Reverse Proxy | `cd task-2-reverse-proxy && docker compose up --build` |
| 3. SPA Fallback | `cd task-3-spa-fallback && npm run build && docker compose up --build` |
| 4. Load Balancing | `cd task-4-load-balancing && docker compose up --build` |
| 5. Rate Limiting | `cd task-5-rate-limiting && docker compose up --build` |
| 6. Access Control | `cd task-6-access-control && docker compose up --build` |
| 7. Security Headers | `cd task-7-security-headers && docker compose up --build` |
| 8. Performance Caching | `cd task-8-performance-caching && docker compose up --build` |
| 9. SSL/HTTPS | `cd task-9-ssl-https && ./generate-certs.sh && docker compose up --build` |
| 10. JSON Logging | `cd task-10-json-logging && docker compose up --build` |
| 11. URL Rewriting | `cd task-11-url-rewriting && docker compose up --build` |
