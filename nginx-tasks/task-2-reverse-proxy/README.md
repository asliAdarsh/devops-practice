# Task 2: Reverse Proxy — The Forwarder

This task demonstrates configuring Nginx as a reverse proxy for a Node.js Express application.

## Overview
- Nginx forwards requests to a Node.js backend via `proxy_pass`
- Client headers (Host, X-Real-IP) are forwarded to the proxied app
- Multi-container setup (Node.js + Nginx)

## Files
- `dockerfile` — Docker image for the Express.js app
- `nginx.conf` — Nginx reverse proxy configuration
- `index.js` — Express.js app with `/` and `/admin` routes
- `package.json` — Node.js dependencies

## Run
```bash
docker build -t node-backend .
docker run -d -p 3000:3000 --name backend node-backend
docker build -t nginx-proxy -f- nginx.conf .
# Then run nginx container that proxies to the backend
```

## Verification
- `curl http://localhost:80` returns response from Node.js backend
- Headers like `X-Real-IP` are correctly forwarded
