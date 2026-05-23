# Nginx Tasks

![Nginx](https://img.shields.io/badge/Nginx-Tasks-009639?style=flat-square&logo=nginx&logoColor=white)

This directory contains hands-on exercises with **Nginx** — configuring it as a static file server, a reverse proxy, and a production-grade frontend server paired with Docker containerization.

---

## Task 1: Static File Serving with Nginx

**Folder:** `task-1/`

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

**Key Concepts Demonstrated:**
- ✅ Custom Nginx Docker image
- ✅ Static content serving
- ✅ Alpine-based minimal images

**Run it:**
```bash
cd task-1
docker build -t nginx-static .
docker run -p 80:80 nginx-static
```

---

## Task 2: Nginx as a Reverse Proxy

**Folder:** `task-2/`

**What I Practiced:**
- Configuring Nginx as a **reverse proxy** in front of a Node.js Express app
- Setting up `proxy_pass` to forward requests to the backend
- Passing client headers (`Host`, `X-Real-IP`) to the proxied application
- Using `events {}` and `http {}` block configuration
- Creating a multi-container setup (Node.js app + Nginx proxy)

**Files:**
| File | Purpose |
|------|---------|
| `dockerfile` | Docker image for the Express.js app |
| `nginx.conf` | Nginx reverse proxy configuration |
| `index.js` | Express.js app with `/` and `/admin` routes |
| `package.json` | Node.js dependencies |

**Key Concepts Demonstrated:**
- ✅ Nginx reverse proxy configuration
- ✅ Header forwarding (`proxy_set_header`)
- ✅ Node.js backend proxying
- ✅ Nginx `location` block routing

**Run it:**
```bash
cd task-2
docker build -t node-backend .
docker run -d -p 3000:3000 --name backend node-backend
# Then run nginx container that proxies to the backend
```

---

## Task 3: React App with Nginx Production Serving

**Folder:** `task-3/`

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
| `README.md` | CRA default README |
| `package.json` | Node.js dependencies |

**Key Concepts Demonstrated:**
- ✅ Production build with Create React App
- ✅ Nginx SPA routing (`try_files $uri /index.html`)
- ✅ Client-side routing with React Router
- ✅ Full-stack frontend deployment preparation

**Run it:**
```bash
cd task-3
# Build the React app
npm run build
# Then serve with Nginx (either with Docker or directly)
```

---

## Nginx Configuration Summary

### Static Server (Task 1)
```nginx
# Default nginx behavior — no custom config needed
server {
    listen 80;
    root /usr/share/nginx/html;
}
```

### Reverse Proxy (Task 2)
```nginx
events {}

http {
  server {
    listen 80;

    location / {
      proxy_pass http://localhost:3000;
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
    }
  }
}
```

### SPA Routing (Task 3 — implicit)
```nginx
server {
    listen 80;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri /index.html;
    }
}
```

---

## Skills Practiced

- ✅ Nginx as a static file server
- ✅ Nginx as a reverse proxy for Node.js applications
- ✅ Configuring virtual hosts and location blocks
- ✅ SPA routing with `try_files` directive
- ✅ Headers and proxy configuration
- ✅ Docker + Nginx integration
- ✅ Production deployment patterns for web applications
