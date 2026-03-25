# Docker Tasks Repository

This repository contains practical Docker implementations covering various concepts and scenarios. Each task folder demonstrates specific Docker features and best practices.


### Task 1: Basic Node.js Application with Security Best Practices
**Folder:** `task-1/`  
**Corresponds to:** Task about running Node.js applications with non-root user

**What's happening:**
- Uses `node:20-alpine` as base image for smaller footprint
- Creates a non-root user (`appuser`) and group (`appgroup`) for security
- Implements proper file ownership with `--chown` flag
- Exposes port 3000 for the Express.js application
- Demonstrates security best practices by avoiding root user execution

**Key Docker Concepts:**
- Multi-stage user creation
- File ownership and permissions
- Security best practices
- Alpine Linux benefits

### Task 2: Python FastAPI Application
**Folder:** `task-2/`  
**Corresponds to:** Task about running Python web applications

**What's happening:**
- Uses official Python base image
- Implements FastAPI web framework with Uvicorn server
- Proper dependency management with requirements.txt
- Exposes port 8000 for the API service
- Demonstrates Python application containerization

**Key Docker Concepts:**
- Python application containerization
- Dependency management
- Web server configuration
- Port exposure

### Task 3: Multi-Container Application with Docker Compose
**Folder:** `task-3/`  
**Corresponds to:** Task about Docker Compose and multi-container applications

**What's happening:**
- Implements a two-service architecture: web application and Redis database
- Uses Docker Compose for orchestration
- Demonstrates service dependencies with `depends_on`
- Implements custom networking with bridge driver
- Environment variable configuration for service communication

**Key Docker Concepts:**
- Docker Compose orchestration
- Service dependencies
- Custom networks
- Environment configuration
- Multi-container communication

### Task 4: Multi-Stage Build with Vite + React + Nginx
**Folder:** `task-4/`  
**Corresponds to:** Task about multi-stage builds and static serving

**What's happening:**
- Implements a true multi-stage build process
- **Stage 1 (builder):** Builds the React application using Vite
- **Stage 2:** Uses nginx:alpine to serve the built static files
- Custom Nginx configuration for SPA routing
- Optimized final image with only necessary artifacts

**Key Docker Concepts:**
- Multi-stage builds
- Build optimization
- Static file serving
- Nginx configuration
- SPA routing with try_files

### Task 5: Create React App with Multi-Stage Build
**Folder:** `task-5/`  
**Corresponds to:** Task about CRA applications and production builds

**What's happening:**
- Similar multi-stage approach but with Create React App
- **Stage 1:** Builds React application using react-scripts
- **Stage 2:** Serves built files with nginx:alpine
- Demonstrates different build tools (react-scripts vs Vite)
- Production-ready containerization

**Key Docker Concepts:**
- Create React App containerization
- Production builds
- Multi-stage optimization
- Static serving

## Important Docker Concepts Covered

### 1. **Security Best Practices**
- Non-root user execution (Task 1)
- Proper file permissions and ownership
- Minimal base images (Alpine)

### 2. **Multi-Stage Builds**
- Separation of build and runtime environments (Tasks 4, 5)
- Reduced final image size
- Improved security by excluding build tools

### 3. **Orchestration**
- Docker Compose for multi-container applications (Task 3)
- Service dependencies and networking
- Environment variable management

### 4. **Web Application Containerization**
- Node.js/Express applications (Task 1)
- Python/FastAPI applications (Task 2)
- React applications (Tasks 4, 5)

### 5. **Static File Serving**
- Nginx configuration for production
- SPA routing support
- Efficient static content delivery

### 6. **Build Optimization**
- Layer caching strategies
- .dockerignore considerations
- Dependency management

## Missing Tasks from the Original 17

The following tasks from the original image are not yet implemented:

- Volume management and data persistence
- Docker networking deep dive
- Docker Swarm orchestration
- Kubernetes deployment
- Docker registry management
- Health checks and monitoring
- Logging and debugging
- Performance optimization
- Security scanning
- CI/CD integration with GitHub Actions
- Microservices architecture
- Database containerization
- Caching strategies
- Load balancing
- Service discovery

## How to Run Each Task

### Task 1 - Node.js App
```bash
cd task-1
docker build -t node-app .
docker run -p 3000:3000 node-app
```

### Task 2 - Python FastAPI
```bash
cd task-2
docker build -t fastapi-app .
docker run -p 8000:8000 fastapi-app
```

### Task 3 - Docker Compose
```bash
cd task-3
docker-compose up --build
```

### Task 4 - Vite React App
```bash
cd task-4
docker build -t vite-react-app .
docker run -p 80:80 vite-react-app
```

### Task 5 - Create React App
```bash
cd task-5
docker build -t cra-react-app .
docker run -p 80:80 cra-react-app
```

## Best Practices Demonstrated

1. **Use specific base image versions** instead of `latest`
2. **Implement multi-stage builds** to reduce image size
3. **Run applications as non-root users** for security
4. **Use .dockerignore** files to exclude unnecessary files
5. **Properly handle dependencies** in separate layers
6. **Expose only necessary ports**
7. **Use health checks** in production (can be added)
8. **Implement proper logging** strategies

## Next Steps

To complete the full 17-task curriculum, consider implementing:
- Volume mounts for data persistence
- Advanced networking configurations
- Docker Swarm for clustering
- Kubernetes deployments
- CI/CD pipeline integration
- Security scanning and vulnerability assessment
- Performance monitoring and logging
