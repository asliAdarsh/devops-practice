# DevOps Practice Repository

![DevOps](https://img.shields.io/badge/DevOps-Practice-blue?style=flat-square)
![Git](https://img.shields.io/badge/Git-Exercises-orange?style=flat-square)
![Docker](https://img.shields.io/badge/Docker-Tasks-2496ED?style=flat-square&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Tasks-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-Practices-7B42BC?style=flat-square&logo=terraform&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Tasks-009639?style=flat-square&logo=nginx&logoColor=white)

A personal hands-on repository documenting my DevOps learning journey. This repo contains practical exercises and projects covering core DevOps tools and concepts including **Git**, **Docker**, **Kubernetes**, **Terraform**, **Nginx**, **CI/CD**, and **Cloud Deployments**.

---

## Repository Structure

```
devops-practice/
├── docker-tasks/          # Docker containerization (5 tasks)
├── git-exercises/         # Git katas & version control exercises
├── kubernetes-tasks/      # Kubernetes deployments & orchestration (3 tasks)
├── nginx-tasks/           # Nginx web server & reverse proxy (3 tasks)
├── terraform-practices/   # Terraform IaC with DigitalOcean
└── assignments/           # End-to-end project: Todo & Notes App
```

---

## Topics Covered

| Area | What I Practiced |
|------|-----------------|
| **🐳 Docker** | Containerizing Node.js, Python, React apps; multi-stage builds; Docker Compose; multi-container apps with Redis; security best practices (non-root users); Nginx + React SPA serving |
| **🌿 Git** | Branching, merging, rebasing, stashing, cherry-pick, bisect, conflict resolution, interactive rebase, submodules, squashing, reflog, reset, revert, tags, attributes, hooks |
| **☸️ Kubernetes** | Deployments, Services (ClusterIP, NodePort, LoadBalancer), ConfigMaps, Secrets, PersistentVolumeClaims, Pods, MongoDB + Mongo Express, PostgreSQL, Nginx, Ingress routing |
| **🔁 Nginx** | Static file serving, reverse proxy configuration, Node.js app proxying, React SPA routing with `try_files`, custom nginx configs in Docker |
| **🏗️ Terraform** | Infrastructure-as-Code with DigitalOcean provider, VPC creation, Droplet provisioning, firewalls, reusable modules, environment separation (dev/prod), `moved` blocks |
| **🚀 CI/CD** | GitHub Actions workflows for Docker build & push, automated CI + CD pipelines, Azure App Service deployment |
| **📦 Full-Stack Deployment** | FastAPI backend + React (Vite) frontend + PostgreSQL, containerized with Docker Compose, deployed on Kubernetes with Ingress |

---

## Quick Start

```bash
# Clone the repo
git clone <repo-url>
cd devops-practice

# Explore any topic — each directory has its own README with details
```

---

## What's Inside Each Module

### 🐳 [docker-tasks](./docker-tasks)
5 progressive Docker exercises:
- **Task 1:** Node.js Express app with non-root security best practices
- **Task 2:** Python FastAPI containerization
- **Task 3:** Multi-container app (Node.js + Redis) using Docker Compose
- **Task 4:** Multi-stage build — Vite + React + Nginx SPA serving
- **Task 5:** Multi-stage build — Create React App with Nginx

### 🌿 [git-exercises](./git-exercises)
A collection of Git katas (exercises) covering ~40+ Git scenarios — from basic commits to advanced interactive rebase, bisect, submodules, and merge drivers. Each kata has its own setup script and README.

### ☸️ [kubernetes-tasks](./kubernetes-tasks)
3 Kubernetes practice scenarios:
- **Task 1:** MongoDB + Mongo Express with ConfigMaps, Secrets, and Services
- **Task 2:** PostgreSQL with PersistentVolumeClaim and Nginx Deployment
- **Task 3:** Ingress routing configuration

### 🔁 [nginx-tasks](./nginx-tasks)
3 Nginx configuration exercises:
- **Task 1:** Simple static file serving via Nginx + Docker
- **Task 2:** Nginx as a reverse proxy for a Node.js app
- **Task 3:** React app built and served with Nginx (production deployment)

### 🏗️ [terraform-practices](./terraform-practices)
Terraform Infrastructure-as-Code using the DigitalOcean provider:
- Modular architecture (`network_layer`, `app_cluster`)
- VPC, firewall, and Droplet provisioning
- Development and production environments
- Reusable Terraform modules with variables

### 📋 [assignments](./assignments)
Full-stack **Todo & Notes App** — the capstone project:
- **Backend:** FastAPI + SQLAlchemy + PostgreSQL (containerized)
- **Frontend:** React + Vite + Nginx (multi-stage Docker build)
- **Orchestration:** Docker Compose for local dev
- **Kubernetes:** Deployments, Services, Ingress, Secrets, ConfigMaps
- **CI/CD:** GitHub Actions — automatic build + push to Docker Hub, deploy to Azure App Service

---

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Kubernetes (Minikube or cluster)](https://kubernetes.io/docs/tasks/tools/)
- [Terraform](https://www.terraform.io/downloads)
- [Git](https://git-scm.com/)
- Node.js & Python (for local development)

---

## Skills Demonstrated

- ✅ Containerization of web applications (Node.js, Python, React)
- ✅ Multi-stage Docker builds for production optimization
- ✅ Multi-container orchestration with Docker Compose
- ✅ Kubernetes resource management (Deployments, Services, Ingress, PVC, ConfigMaps, Secrets)
- ✅ Nginx configuration (static serving, reverse proxy, SPA routing)
- ✅ Infrastructure-as-Code with Terraform modules
- ✅ CI/CD pipelines with GitHub Actions
- ✅ Cloud deployment to Azure App Service
- ✅ Git version control mastery (branching, rebasing, stashing, etc.)

---

## Author

**Adarsh** — DevOps learner & practitioner

---

*This is a personal learning repository. Feel free to explore and use it as a reference for your own DevOps journey!*
