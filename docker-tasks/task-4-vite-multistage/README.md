# Task 4: Multi-Stage Build with Vite + React + Nginx

This task demonstrates how to create a production-ready React application using multi-stage Docker builds with Vite and Nginx.

## Overview

- **Frontend:** React application built with Vite
- **Build Stage:** Node.js environment for building the app
- **Production Stage:** Nginx serving static files
- **Port:** 80

## Multi-Stage Architecture

```
┌─────────────────┐    ┌─────────────────┐
│   Builder Stage │───▶│ Production Stage│
│   (Node.js)     │    │   (Nginx)       │
│  - npm install  │    │  - Static files │
│  - npm run build│    │  - SPA routing  │
└─────────────────┘    └─────────────────┘
```

## Files

- `src/` - React application source code
- `public/` - Static assets
- `package.json` - Dependencies and build scripts
- `dockerfile` - Multi-stage build configuration
- `nginx.conf` - Nginx configuration for SPA routing
- `vite.config.js` - Vite build configuration

## How to Run

### Build the Docker Image
```bash
docker build -t vite-react-app .
```

### Run the Container
```bash
docker run -p 80:80 --name vite-react-container vite-react-app
```

### Access the Application
Open your browser and navigate to: `http://localhost`

## Development

### Install Dependencies
```bash
npm install
```

### Run Development Server
```bash
npm run dev
```

### Build for Production Locally
```bash
npm run build
```

### Preview Production Build
```bash
npm run preview
```

## Docker Multi-Stage Build Benefits

1. **Smaller Final Image:** Only Nginx and built files, no Node.js
2. **Improved Security:** No build tools in production
3. **Better Performance:** Optimized static file serving
4. **Clean Separation:** Build and runtime concerns separated

## Nginx Configuration

The `nginx.conf` provides:
- Static file serving from `/usr/share/nginx/html`
- SPA routing support with `try_files`
- Efficient file handling
- Default index.html serving

## Build Process

1. **Stage 1 (Builder):**
   - Install dependencies
   - Build React application with Vite
   - Output: `/app/dist` directory

2. **Stage 2 (Production):**
   - Copy built files from builder stage
   - Configure Nginx
   - Serve static content

## Clean Up

Stop and remove the container:
```bash
docker stop vite-react-container
docker rm vite-react-container
```

Remove the image:
```bash
docker rmi vite-react-app
```

## Troubleshooting

### Check Build Output
```bash
docker run --rm -it vite-react-app ls -la /usr/share/nginx/html
```

### Access Container Shell
```bash
docker run -it --rm vite-react-app sh
```

### View Nginx Logs
```bash
docker logs vite-react-container
```
