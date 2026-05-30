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
├── docker-tasks/          # Docker containerization (17 tasks)
├── git-exercises/         # Git katas & version control exercises
├── kubernetes-tasks/      # Kubernetes deployments & orchestration (12 tasks incl. capstone)
├── nginx-tasks/           # Nginx web server & reverse proxy (11 tasks)
├── terraform-practices/   # Terraform IaC with DigitalOcean & GCP (14 levels + modules)
└── assignments/           # End-to-end project: Totes App (Todo & Notes)
```

---

## Topics Covered

| Area | What I Practiced |
|------|-----------------|
| **🐳 Docker** | Containerizing Node.js, Python, React apps; multi-stage builds; Docker Compose; volumes & bind mounts; custom networks; health checks; resource limits; logging; multi-arch builds; image registry; Docker Swarm orchestration |
| **🌿 Git** | Branching, merging, rebasing, stashing, cherry-pick, bisect, conflict resolution, interactive rebase, submodules, squashing, reflog, reset, revert, tags, attributes, hooks |
| **☸️ Kubernetes** | Cluster setup, Pods, Deployments, Services (ClusterIP, NodePort, LoadBalancer), ConfigMaps, Secrets, PersistentVolumeClaims, Ingress, Horizontal scaling, Rolling updates, Service discovery, Block storage, Full capstone microservice |
| **🔁 Nginx** | Static file serving, reverse proxy, SPA routing, load balancing, rate limiting, access control, security headers, caching, SSL/HTTPS, JSON logging, URL rewriting |
| **🏗️ Terraform** | **DigitalOcean:** VPC creation, Droplet provisioning, firewalls, reusable modules, environment separation (dev/prod), `moved` blocks — **GCP (14 levels):** Local state, variables/backends, custom VPC, private compute, NAT, modules, Cloud SQL, CI/CD, project factories, Shared VPC, IAM, GitOps, Workload Identity Federation |
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
17 progressive Docker exercises:
- **Task 1:** Node.js Express app with non-root security best practices
- **Task 2:** Python FastAPI containerization
- **Task 3:** Multi-container app (Node.js + Redis) using Docker Compose
- **Task 4:** Multi-stage build — Vite + React + Nginx SPA serving
- **Task 5:** Multi-stage build — Create React App with Nginx
- **Task 6:** Basic Nginx static file server
- **Task 7:** Ephemeral filesystem (data loss demonstration)
- **Task 8:** Named volumes for data persistence
- **Task 9:** Custom Docker networks
- **Task 10:** Bind mounts for live development
- **Task 11:** Persistent volumes with PostgreSQL
- **Task 12:** Container health checks
- **Task 13:** CPU and memory resource limits
- **Task 14:** Logging and debugging
- **Task 15:** Multi-architecture builds with Buildx
- **Task 16:** Local Docker image registry
- **Task 17:** Docker Swarm orchestration

### 🌿 [git-exercises](./git-exercises)
A collection of Git katas (exercises) covering ~40+ Git scenarios — from basic commits to advanced interactive rebase, bisect, submodules, and merge drivers. Each kata has its own setup script and README.

### ☸️ [kubernetes-tasks](./kubernetes-tasks)
12 Kubernetes practice scenarios (incl. capstone):
- **Task 1:** ConfigMaps & Secrets — MongoDB + Mongo Express
- **Task 2:** Persistent Storage — PostgreSQL with PVC
- **Task 3:** Ingress — path-based routing
- **Task 4:** Cluster setup with Minikube
- **Task 5:** Basic Pods — YAML fundamentals
- **Task 6:** Deployments & self-healing
- **Task 7:** Service discovery & DNS
- **Task 8:** Horizontal scaling (replicas)
- **Task 9:** Rolling updates & rollbacks
- **Task 10:** LoadBalancer Services
- **Task 11:** Block storage with PVCs
- **Task 12:** Capstone — Full microservice (Frontend + Backend + MongoDB)

### 🔁 [nginx-tasks](./nginx-tasks)
11 Nginx configuration exercises:
- **Task 1:** Static file serving with Nginx + Docker
- **Task 2:** Reverse proxy for a Node.js app
- **Task 3:** React SPA fallback routing with `try_files`
- **Task 4:** Load balancing across multiple backends
- **Task 5:** Rate limiting
- **Task 6:** Access control with HTTP Basic Auth
- **Task 7:** Security headers (CSP, HSTS, X-Frame-Options)
- **Task 8:** Performance caching (proxy_cache)
- **Task 9:** SSL/HTTPS with self-signed certificates
- **Task 10:** JSON structured logging
- **Task 11:** URL rewriting & redirects

### 🏗️ [terraform-practices](./terraform-practices)

**Two cloud providers, two practice tracks:**

#### ☁️ [DigitalOcean Practice](./terraform-practices/digital-ocean-practice)
- **Provisioning**: VPC, Droplets, firewalls, tags via reusable modules
- **Architecture**: 2 environments (dev + prod) with `network_layer` and `app_cluster` modules
- **Concepts**: Multi-environment via variables, `moved` block refactoring, module composition
- **Theme**: The Network Architect · The Compute Runner · The Orchestrator

#### 🌐 [GCP Practice](./terraform-practices/gcp-practice) — 14 Progressive Levels
| Level | Theme | What I Practiced |
|-------|-------|------------------|
| L1 | The Footprint | First GCS bucket, local state, provider handshake |
| L2 | The Variable Lab | Variable separation, env validation, .tfvars layers |
| L3 | The State Guardian | Remote GCS backend, state locking, migration |
| L4 | The Network Architect | Custom VPC, private subnet, IAP SSH firewall |
| L5 | The Fortress | Private VM (no public IP), data sources, IAP tunnel |
| L6 | The Outbound Gate | Cloud Router + NAT, one-way outbound internet |
| L7 | The Architect | Local modules, reusable gcp_bucket abstraction |
| L8 | The Data Vault | Private Cloud SQL PostgreSQL, PSA, VPC peering |
| L9 | The Pipeline | Monorepo CI/CD, path-filtered GitHub Actions |
| L10 | The Factory | Org-level project factory (hub + spoke), random_id |
| L11 | The Conduit | Shared VPC, provider aliasing, host/service project |
| L12 | The Gatekeeper | Cross-project IAM, subnet-level least privilege |
| L13 | The Guardian | GitOps PR pipeline, fmt-check, speculative plans |
| L14 | The Master Key | Workload Identity Federation, OIDC, secretless auth |

### 📋 [assignments](./assignments)
Full-stack **Totes App (Todo & Notes)** — the capstone project:
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
- ✅ Infrastructure-as-Code with Terraform modules (GCP + DigitalOcean)
- ✅ GCP infrastructure: VPC, private compute, Cloud NAT, Cloud SQL, Shared VPC
- ✅ Terraform modular design with reusable abstractions
- ✅ Remote state management with GCS backend + state locking
- ✅ GitHub Actions CI/CD for Terraform (path-filtered monorepo, PR plan comments)
- ✅ Workload Identity Federation & OIDC for secretless authentication
- ✅ Multi-cloud IaC patterns (GCP provider + DigitalOcean provider)
- ✅ CI/CD pipelines with GitHub Actions
- ✅ Cloud deployment to Azure App Service
- ✅ Git version control mastery (branching, rebasing, stashing, etc.)

---

## Author

**Adarsh** — DevOps learner & practitioner

---

*This is a personal learning repository. Feel free to explore and use it as a reference for your own DevOps journey!*
