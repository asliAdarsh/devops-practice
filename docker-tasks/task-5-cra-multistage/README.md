# Task 5: Multi-Stage Build with Create React App

This task demonstrates how to containerize a Create React App (CRA) application using multi-stage Docker builds for production deployment with Nginx.

## Overview

- **Frontend:** React application built with Create React App
- **Build Stage:** Node.js environment for building the app with react-scripts
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

| File | Purpose |
|------|---------|
| `src/` | React application source code |
| `public/` | Static assets (favicon, index.html) |
| `package.json` | Dependencies and build scripts |
| `dockerfile` | Multi-stage build configuration |

## How to Run

### Build the Docker Image
```bash
docker build -t cra-react-app .
```

### Run the Container
```bash
docker run -p 80:80 --name cra-react-container cra-react-app
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
npm start
```

### Build for Production Locally
```bash
npm run build
```

## Docker Multi-Stage Build Benefits

1. **Smaller Final Image:** Only Nginx and built files, no Node.js
2. **Improved Security:** No build tools or dev dependencies in production
3. **Better Performance:** Optimized static file serving with Nginx
4. **Clean Separation:** Build and runtime concerns separated

## Clean Up

Stop and remove the container:
```bash
docker stop cra-react-container
docker rm cra-react-container
```

Remove the image:
```bash
docker rmi cra-react-app
```

## Key Concepts

- **Multi-stage builds** keep production images lean by separating build and runtime environments
- **react-scripts** handles Webpack configuration, Babel transpilation, and production optimizations
- **Nginx** serves the built static files efficiently with built-in caching and compression
