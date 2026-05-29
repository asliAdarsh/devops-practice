# Task 12: Capstone — End-to-End Microservice Deployment

## Task Overview
This **capstone project** ties together all Kubernetes concepts learned in previous tasks. You will deploy a complete **multi-tier microservice application**: a React frontend, a Node.js API backend, and a MongoDB database, all connected through proper service discovery, with persistent storage and external access.

## Key Concepts
- **Multi-Tier Architecture**: Frontend → Backend API → Database
- **ConfigMaps & Secrets**: Configuration and credentials management
- **Persistent Volumes**: Database data persistence
- **Services**: Internal ClusterIP and external LoadBalancer
- **Ingress**: Path-based routing to frontend and backend

## Architecture
```
Internet → Ingress → Frontend Service → Frontend Pod
                    → Backend Service  → Backend API Pod → MongoDB Service → MongoDB Pod (PVC)
```

## Files in This Task

| File | Purpose |
|------|---------|
| `frontend-deployment.yaml` | React frontend Deployment + ClusterIP Service |
| `backend-deployment.yaml` | Node.js API Deployment + ClusterIP Service |
| `mongodb-deployment.yaml` | MongoDB StatefulSet + PVC + ClusterIP Service |
| `configmap.yaml` | Application configuration |
| `secret.yaml` | Database credentials |
| `ingress.yaml` | Ingress for path-based routing |

## Step-by-Step Instructions

### 1. Create the database layer
```bash
kubectl apply -f secret.yaml
kubectl apply -f configmap.yaml
kubectl apply -f mongodb-deployment.yaml
kubectl get pods -w
```

### 2. Deploy the backend API
```bash
kubectl apply -f backend-deployment.yaml
kubectl get pods -w
```

### 3. Deploy the frontend
```bash
kubectl apply -f frontend-deployment.yaml
```

### 4. Configure Ingress
```bash
kubectl apply -f ingress.yaml
```

### 5. Access the application
```bash
minikube service frontend-service
```

## Verification Steps
- [ ] MongoDB pod is running with persistent storage
- [ ] Backend API can connect to MongoDB
- [ ] Frontend can communicate with backend API
- [ ] Ingress routes `/` to frontend and `/api/` to backend
- [ ] All resources (Deployments, Services, PVC, ConfigMap, Secret, Ingress) are verified

## Success Criteria
- [ ] All 3 tiers communicate correctly
- [ ] Data persists across pod restarts
- [ ] Application is accessible externally via Ingress
- [ ] Secrets and ConfigMaps are properly separated
- [ ] Understanding the full lifecycle of a Kubernetes application
