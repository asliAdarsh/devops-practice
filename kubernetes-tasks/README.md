# Kubernetes Practice Tasks

![Kubernetes](https://img.shields.io/badge/Kubernetes-Tasks-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
![Tasks](https://img.shields.io/badge/Tasks-12%20%2B%201%20Capstone-success?style=flat-square)

A structured, hands-on learning path for Kubernetes. Each task builds on the previous one, starting from cluster setup and progressing to a full microservice deployment.

---

## Learning Path — Task Progression

```
Task 4  ──→  Task 5  ──→  Task 6  ──→  Task 7
 (Setup)     (Pod)       (Deploy)     (Service)

Task 1  ──→  Task 2  ──→  Task 3
 (Config)    (Storage)   (Ingress)

Task 8  ──→  Task 9  ──→  Task 10 ──→  Task 11
 (Scaling)   (Update)    (LB)        (CSI)

                     ↓
              Task 12 (Capstone)
```

> **Suggested Order:** Start at Task 4 (Cluster Setup) if you're setting up from scratch. Then follow: 5, 6, 7, 1, 2, 3, 8, 9, 10, 11, then the Capstone (12).

---

## Task Index

| # | Task | Folder | What You Learn |
|---|------|--------|----------------|
| 4 | **Cluster Setup** — The First Breath | [`task-4-cluster-setup/`](./task-4-cluster-setup/) | Install Minikube, start a cluster, understand kubectl |
| 5 | **Basic Pod** — The Manual Pod | [`task-5-basic-pod/`](./task-5-basic-pod/) | YAML structure, pod lifecycle, kubectl commands |
| 6 | **Deployment & Self-Healing** — The Manager | [`task-6-deployment-self-healing/`](./task-6-deployment-self-healing/) | ReplicaSets, self-healing, liveness probes |
| 7 | **Service Discovery** — The Receptionist | [`task-7-service-discovery/`](./task-7-service-discovery/) | ClusterIP, DNS discovery, kube-proxy |
| 1 | **ConfigMaps & Secrets** — The Injector | [`task-1-configmaps-secrets/`](./task-1-configmaps-secrets/) | Secrets, ConfigMaps, env var injection |
| 2 | **Persistent Storage** — The Locker | [`task-2-persistent-storage/`](./task-2-persistent-storage/) | PVC, PV, pod vs deployment storage |
| 3 | **Ingress** — The Traffic Cop | [`task-3-ingress/`](./task-3-ingress/) | Path-based routing, rewrite-target, ingress controller |
| 8 | **Horizontal Scaling** — The Flood | [`task-8-horizontal-scaling/`](./task-8-horizontal-scaling/) | HPA, metrics-server, resource requests/limits |
| 9 | **Rolling Update** — The Rolling Update | [`task-9-rolling-update/`](./task-9-rolling-update/) | Rollout strategies, maxSurge, rollback |
| 10 | **LoadBalancer** — The Public IP | [`task-10-loadbalancer/`](./task-10-loadbalancer/) | LoadBalancer type, minikube tunnel, external access |
| 11 | **Block Storage** — The Block Storage | [`task-11-block-storage/`](./task-11-block-storage/) | CSI, StorageClass, dynamic provisioning |
| 12 | **Capstone — Resilient Microservice** | [`task-12-capstone-microservice/`](./task-12-capstone-microservice/) | Full stack: frontend + API + DB + Ingress + HPA |

---

## Common Commands Reference

### Cluster Management
```bash
minikube start --driver=docker --cpus=2 --memory=2048
minikube status
minikube stop
minikube delete
minikube dashboard
minikube tunnel
minikube addons enable ingress
minikube addons enable metrics-server
```

### kubectl Basics
```bash
kubectl get nodes
kubectl get pods -A
kubectl cluster-info
kubectl config current-context
```

### Resource Management
```bash
kubectl apply -f <file.yaml>
kubectl delete -f <file.yaml>

kubectl get pods [-o wide | -o yaml]
kubectl get deployments
kubectl get services
kubectl get ingress
kubectl get pvc
kubectl get pv
kubectl get configmaps
kubectl get secrets
kubectl get hpa
kubectl get replicasets
kubectl get endpoints
kubectl get storageclass
```

### Debugging
```bash
kubectl describe pod <name>
kubectl describe deployment <name>
kubectl describe service <name>

kubectl logs <pod-name>
kubectl logs deployment/<deploy-name>

kubectl exec <pod-name> -- <command>
kubectl exec deployment/<deploy-name> -- <command>

kubectl port-forward service/<svc-name> <local>:<remote>
kubectl port-forward pod/<pod-name> <local>:<remote>
```

### Scaling & Updates
```bash
kubectl scale deployment <name> --replicas=5
kubectl set image deployment/<name> <container>=<new-image>
kubectl rollout status deployment/<name>
kubectl rollout history deployment/<name>
kubectl rollout undo deployment/<name>
kubectl rollout pause deployment/<name>
kubectl rollout resume deployment/<name>
```

### Resource Usage
```bash
kubectl top nodes
kubectl top pods
kubectl top pods --containers
```

---

## Resource Type Reference

| Resource | apiVersion | Kind | Purpose |
|----------|-----------|------|---------|
| **Pod** | `v1` | `Pod` | Single container or group of containers |
| **Deployment** | `apps/v1` | `Deployment` | Declarative pod management with ReplicaSets |
| **StatefulSet** | `apps/v1` | `StatefulSet` | Stateful applications with stable identity |
| **Service (ClusterIP)** | `v1` | `Service` | Internal DNS-based service discovery |
| **Service (NodePort)** | `v1` | `Service` | External access via node port (30000-32767) |
| **Service (LoadBalancer)** | `v1` | `Service` | External access via cloud LB |
| **Ingress** | `networking.k8s.io/v1` | `Ingress` | HTTP/HTTPS routing to services |
| **ConfigMap** | `v1` | `ConfigMap` | Non-sensitive configuration data |
| **Secret** | `v1` | `Secret` | Sensitive data (base64 encoded) |
| **PersistentVolumeClaim** | `v1` | `PersistentVolumeClaim` | Storage request for pods |
| **StorageClass** | `storage.k8s.io/v1` | `StorageClass` | Defines storage tiers/provisioners |
| **HorizontalPodAutoscaler** | `autoscaling/v2` | `HorizontalPodAutoscaler` | Auto-scaling based on metrics |
| **ReplicaSet** | `apps/v1` | `ReplicaSet` | Ensures desired pod count (managed by Deployment) |

---

## Skills Covered

By completing all 12 tasks, you will have practiced:

- [x] Cluster setup with Minikube
- [x] YAML resource definitions (apiVersion, kind, metadata, spec)
- [x] Pod lifecycle and debugging
- [x] Deployments and ReplicaSets (self-healing)
- [x] Service discovery and DNS resolution
- [x] Configuration management (ConfigMaps, Secrets)
- [x] Persistent storage (PVC, PV, CSI, StorageClass)
- [x] Ingress routing (path-based, rewrite-target)
- [x] Horizontal Pod Autoscaling (HPA)
- [x] Rolling updates and rollbacks
- [x] External access (LoadBalancer, NodePort)
- [x] StatefulSets for stateful workloads
- [x] Multi-service microservice architecture

---

## Quick Start

Want to start from scratch? Run:

```bash
# 1. Clone or navigate to this repo
cd devops-practice/kubernetes-tasks

# 2. Start Minikube
minikube start --driver=docker --cpus=2 --memory=4096

# 3. Start with Task 4 (Cluster Setup)
cd task-4-cluster-setup
# Follow the instructions in README.md
```

---

## Notes

- All YAML files use `apiVersion` compatible with Kubernetes 1.20+
- Tasks use official Docker images (nginx, postgres, alpine, etc.)
- Minikube is the recommended local cluster for all tasks
- Each task's README includes common mistakes and their solutions
- The capstone (Task 12) combines concepts from all previous tasks

---

*Happy Kuberneting!*
