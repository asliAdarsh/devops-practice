# Kubernetes Tasks

![Kubernetes](https://img.shields.io/badge/Kubernetes-Tasks-326CE5?style=flat-square&logo=kubernetes&logoColor=white)

This directory contains hands-on Kubernetes exercises covering core concepts like **Pods**, **Deployments**, **Services**, **ConfigMaps**, **Secrets**, **PersistentVolumeClaims**, and **Ingress** routing.

---

## Task 1: MongoDB + Mongo Express with ConfigMaps & Secrets

**Folder:** `task1/`

**What I Practiced:**
- Creating a **Secret** (`secret.yaml`) to store MongoDB credentials (base64-encoded)
- Creating a **ConfigMap** (`configmap.yaml`) to store the database service URL
- Deploying **MongoDB** as a Deployment with a ClusterIP Service
- Deploying **Mongo Express** (web admin UI) as a Deployment with a LoadBalancer Service
- Injecting sensitive data via `valueFrom.secretKeyRef` and non-sensitive config via `configMapKeyRef`
- Exposing Mongo Express externally via `NodePort: 30000`

**Files:**
| File | Purpose |
|------|---------|
| `secret.yaml` | MongoDB credentials (base64) |
| `configmap.yaml` | Database URL config |
| `mongodb-deployment.yaml` | MongoDB Deployment + Service (port 27017) |
| `mongoexpress-deployment.yaml` | Mongo Express Deployment + LoadBalancer Service (port 8081) |

**Key Concepts Demonstrated:**
- ✅ Secrets & ConfigMaps for configuration management
- ✅ Environment variable injection from Kubernetes resources
- ✅ Multi-container communication within the cluster
- ✅ LoadBalancer Service type for external access

---

## Task 2: PostgreSQL with Persistent Storage + Nginx

**Folder:** `task2/`

**What I Practiced:**
- Creating a **PersistentVolumeClaim** (`psql-pvc.yaml`) for data persistence (1Gi)
- Deploying **PostgreSQL** as a raw **Pod** (not Deployment) with volume mounts
- Using `POSTGRES_PASSWORD` environment variable for database authentication
- Deploying **Nginx** as a **Deployment** with a ClusterIP Service
- Understanding the difference between Pods and Deployments

**Files:**
| File | Purpose |
|------|---------|
| `psql-pvc.yaml` | PersistentVolumeClaim (1Gi, ReadWriteOnce) |
| `psql-deploy.yaml` | PostgreSQL Pod with PVC mount + environment config |
| `nginx-deploy.yaml` | Nginx Deployment + ClusterIP Service (port 80) |

**Key Concepts Demonstrated:**
- ✅ PersistentVolumeClaims for stateful workloads
- ✅ Pod-level volume mounting
- ✅ Stateless vs stateful application deployment
- ✅ ClusterIP internal service exposure

---

## Task 3: Ingress Routing

**Folder:** `task-3/`

**What I Practiced:**
- Configuring **Kubernetes Ingress** for HTTP/HTTPS routing
- Setting up path-based routing rules
- Using `nginx.ingress.kubernetes.io/rewrite-target` annotation for URL rewriting
- Routing frontend (`/`) and backend API (`/api/`) traffic to different services

**Files:**
| File | Purpose |
|------|---------|
| `ingress-deploy.yaml` | Ingress resource with path-based routing |

**Key Concepts Demonstrated:**
- ✅ Ingress resource configuration
- ✅ Path-based routing to multiple backend services
- ✅ URL rewriting with annotations
- ✅ Exposing multiple services under a single IP

---

## Quick Reference

### Common Commands

```bash
# Apply a resource
kubectl apply -f <file.yaml>

# Get resources
kubectl get pods
kubectl get deployments
kubectl get services
kubectl get pvc
kubectl get ingress

# Describe a resource for debugging
kubectl describe pod <pod-name>
kubectl describe service <service-name>

# Port forwarding
kubectl port-forward service/<service-name> <local-port>:<remote-port>

# Delete resources
kubectl delete -f <file.yaml>
```

### Resource Types Used

| Resource | Purpose |
|----------|---------|
| **Pod** | Single instance of a running application |
| **Deployment** | Declarative updates for Pods and ReplicaSets |
| **Service (ClusterIP)** | Internal cluster communication |
| **Service (LoadBalancer)** | External access to services |
| **Service (NodePort)** | External access via node port |
| **ConfigMap** | Non-sensitive configuration data |
| **Secret** | Sensitive data (base64 encoded) |
| **PersistentVolumeClaim** | Storage request for stateful apps |
| **Ingress** | HTTP/HTTPS routing rules |

---

## Skills Practiced

- ✅ Declarative Kubernetes resource management with YAML
- ✅ Configuration separation (ConfigMaps vs Secrets)
- ✅ Stateful application deployment with persistent storage
- ✅ Service discovery and inter-service communication
- ✅ External traffic routing with Ingress
- ✅ Environment variable injection from Kubernetes resources
