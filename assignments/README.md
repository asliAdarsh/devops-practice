# Assignments — Totes App (Todo & Notes)

![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white)
![React](https://img.shields.io/badge/Frontend-React-61DAFB?style=flat-square&logo=react&logoColor=black)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-4169E1?style=flat-square&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Deployed-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
![Azure](https://img.shields.io/badge/Azure-App_Service-0078D4?style=flat-square&logo=microsoftazure&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/CI/CD-GitHub_Actions-2088FF?style=flat-square&logo=githubactions&logoColor=white)

This is the **capstone project** — a full-stack **Totes (Todo & Notes)** application that combines all the DevOps tools and practices learned throughout this repository. It demonstrates the entire lifecycle from development to production deployment.

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     User (Browser)                       │
└────────────────────────┬────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│              Nginx (Frontend - Port 80)                  │
│          Serves React SPA (Vite + React)                 │
│                   OR                                      │
│    Kubernetes Ingress (path-based routing)               │
│         / → frontend-service:80                           │
│      /api → backend-service:8000                          │
└────────────────────────┬────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│          FastAPI Backend (Port 8000)                     │
│       SQLAlchemy ORM + Pydantic Schemas                  │
│       RESTful Endpoints: /todos, /notes                  │
└────────────────────────┬────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│            PostgreSQL Database (Port 5432)               │
│                    Tables:                               │
│              - todos (id, title, notes, completed)       │
│              - standalone_notes (id, title, content)     │
└─────────────────────────────────────────────────────────┘
```

---

## 📁 Project Structure

```
totes-app/
├── backend/                    # FastAPI Python backend (Git submodule → totes-backend)
│   ├── main.py                 # API endpoints + DB models
│   ├── dockerfile              # Docker image for backend
│   ├── requirements.txt        # Python dependencies
│   ├── .env                    # Environment variables
│   ├── .github/workflows/
│   │   ├── main.yml            # Backend CI: build & push to Docker Hub
│   │   └── cd.yml              # Backend CD: deploy to Azure App Service
│   └── todos.db                # Local SQLite fallback
│
├── frontend/                   # React + Vite frontend (Git submodule → totes-frontend)
│   ├── src/
│   │   ├── App.jsx             # Main app with routing
│   │   ├── pages/TasksPage.jsx # Todo management page
│   │   ├── pages/NotesPage.jsx # Notes management page
│   │   ├── components/TodoItem.jsx  # Todo item component
│   │   └── api.js              # API client
│   ├── dockerfile              # Multi-stage build (build + nginx serve)
│   ├── nginx.conf              # Nginx config for SPA routing
│   ├── .github/workflows/
│   │   ├── ci.yml              # Frontend CI: build with VITE_API_URL arg & push
│   │   └── cd.yml              # Frontend CD: deploy to Azure App Service
│   └── dist/                   # Production build output
│
├── docker-compose.yml          # Local dev orchestration (PostgreSQL + Backend + Frontend)
│
└── deployment/                 # Kubernetes manifests
    ├── backend-deployment.yaml # Backend Deployment + ClusterIP Service
    ├── frontend-deployment.yaml# Frontend Deployment + ClusterIP Service
    ├── ingress-routing.yaml    # Ingress with path-based routing
    ├── nodeport.yaml           # Alternative: NodePort service for frontend
    ├── secrets.yaml            # Database connection secret
    └── patch-config.yaml       # Ingress controller ConfigMap patch
```

---

## 🚀 Features

### Backend API (FastAPI)

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/health` | Health check |
| `GET` | `/todos` | List all todos |
| `POST` | `/todos` | Create a todo |
| `PUT` | `/todos/{id}` | Update a todo |
| `DELETE` | `/todos/{id}` | Delete a todo |
| `GET` | `/notes` | List all notes |
| `POST` | `/notes` | Create a note |
| `PUT` | `/notes/{id}` | Update a note |
| `DELETE` | `/notes/{id}` | Delete a note |

### Frontend (React + Vite)

- Todo management (CRUD operations)
- Notes management (CRUD operations)
- API integration with Axios
- Vite for fast development & optimized production builds
- Responsive UI with custom CSS

---

## 🐳 Docker & Local Development

### Docker Compose (Local)

```bash
cd assignments/totes-app
docker-compose up --build
```

This spins up:
1. **PostgreSQL 15** (with health check)
2. **FastAPI Backend** (port 8000)
3. **React Frontend** via Nginx (port 80)

### Dockerfiles

**Backend** — Single-stage Python image:
```dockerfile
FROM python:3.10-slim
# Install deps, run uvicorn on port 8000
```

**Frontend** — Multi-stage build:
```dockerfile
# Stage 1: Build (Node + Vite)
FROM node:alpine as build
ARG VITE_API_URL
ENV VITE_API_URL=$VITE_API_URL
RUN npm run build

# Stage 2: Serve (Nginx)
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
```

---

## ☸️ Kubernetes Deployment

### Resources Deployed

| Resource | Purpose |
|----------|---------|
| **Secret** (`secrets.yaml`) | Database URL for backend |
| **ConfigMap** (`patch-config.yaml`) | Ingress controller config |
| **Backend Deployment** | FastAPI app (1 replica, port 8000) |
| **Backend Service** | ClusterIP for internal access |
| **Frontend Deployment** | React SPA (1 replica, port 80) |
| **Frontend Service** | ClusterIP for internal access |
| **NodePort Service** | Alternative external access (port 30080) |
| **Ingress** | Path-based routing (`/` → frontend, `/api/` → backend) |

### Ingress Rules

```yaml
- path: /(.*)        # Frontend
  backend: frontend-service:80
- path: /api/?(.*)   # Backend (rewrite /api/ → /)
  backend: backend-service:8000
```

```bash
# Deploy to Kubernetes
kubectl apply -f deployment/secrets.yaml
kubectl apply -f deployment/backend-deployment.yaml
kubectl apply -f deployment/frontend-deployment.yaml
kubectl apply -f deployment/ingress-routing.yaml
```

---

## 🔄 CI/CD Pipelines (GitHub Actions)

### Backend CI (`main.yml`)
```yaml
on: push to main
jobs:
  - Build Docker image
  - Push to Docker Hub (asliadarsh/totes-backend:<sha>)
```

### Backend CD (`cd.yml`)
```yaml
on: workflow_dispatch
jobs:
  - Deploy image to Azure App Service (TOTES-BACKEND-APP-SERVICE)
```

### Frontend CI (`ci.yml`)
```yaml
on: push to main
jobs:
  - Build Docker image with VITE_API_URL build-arg
  - Push to Docker Hub (asliadarsh/totes-frontend:<sha>)
```

### Frontend CD (`cd.yml`)
```yaml
on: workflow_dispatch
jobs:
  - Deploy image to Azure App Service (TOTES-FRONTEND-APP-SERVICE)
```

---

## ☁️ Cloud Deployment (Azure)

Both frontend and backend are deployed to **Azure App Service**:
- Backend: `TOTES-BACKEND-APP-SERVICE`
- Frontend: `TOTES-FRONTEND-APP-SERVICE`
- Images stored on **Docker Hub** under `asliadarsh/` account
- Deployment triggered manually via GitHub Actions workflow_dispatch

---

## 📦 Git Submodules

This project uses **Git submodules** to link the backend and frontend to their own GitHub repositories:

| Component | GitHub Repo | Path |
|-----------|-------------|------|
| **Backend** | [asliAdarsh/totes-backend](https://github.com/asliAdarsh/totes-backend) | `assignments/totes-app/backend` |
| **Frontend** | [asliAdarsh/totes-frontend](https://github.com/asliAdarsh/totes-frontend) | `assignments/totes-app/frontend` |

### Cloning with Submodules

```bash
# Clone the parent repo with all submodules
git clone --recurse-submodules <repo-url>

# Or if already cloned, initialize submodules
git submodule update --init --recursive
```

### Updating Submodules

```bash
# Pull latest changes in all submodules
git submodule update --remote --merge

# Or update a specific submodule
cd assignments/totes-app/backend
git pull origin main
```

---

## Skills Demonstrated

### DevOps
- ✅ Full application containerization with Docker
- ✅ Multi-container orchestration with Docker Compose
- ✅ Kubernetes resource management (Deployments, Services, Ingress, Secrets)
- ✅ GitHub Actions CI/CD pipelines
- ✅ Cloud deployment to Azure App Service
- ✅ Docker Hub image registry management
- ✅ Git submodule management for component separation

### Development
- ✅ FastAPI backend with SQLAlchemy ORM
- ✅ React + Vite frontend with routing
- ✅ RESTful API design (CRUD operations)
- ✅ PostgreSQL database integration
- ✅ Multi-stage Docker builds for production optimization
- ✅ Nginx SPA routing configuration
- ✅ Environment-specific configuration (ARG/ENV in Docker)

---

## Skills Practiced

- ✅ Full-stack application development
- ✅ Containerization of frontend + backend + database
- ✅ Kubernetes deployment manifests
- ✅ Ingress-based traffic routing
- ✅ CI/CD pipeline automation
- ✅ Cloud deployment to Azure
- ✅ Secrets management in CI/CD and Kubernetes
- ✅ Multi-stage build optimization
- ✅ Git submodule setup and management
