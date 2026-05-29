# Task 2: Persistent Storage — The Locker

![Kubernetes](https://img.shields.io/badge/Kubernetes-Persistent%20Storage-326CE5?style=flat-square&logo=kubernetes&logoColor=white)

---

## 1. Task Overview

This task teaches you how to **persist data beyond a pod's lifecycle** using PersistentVolumeClaims (PVCs). You will:

- Create a PVC to request storage (1Gi)
- Deploy PostgreSQL as a raw Pod that mounts the PVC
- Deploy Nginx as a Deployment with a ClusterIP Service
- Understand the difference between **stateful** (PostgreSQL) and **stateless** (Nginx) workloads

---

## 2. Key Concepts

- **PersistentVolumeClaim (PVC)** — A request for storage. Kubernetes automatically provisions a PersistentVolume (PV) to satisfy the claim.
- **PersistentVolume (PV)** — A piece of storage in the cluster provisioned by an administrator or dynamically via StorageClass.
- **Access Modes** — `ReadWriteOnce` (single node), `ReadOnlyMany` (multiple nodes read), `ReadWriteMany` (multiple nodes read/write).
- **Volume Mounts** — Attaching storage to a container at a specific path (`mountPath`).
- **Pod vs Deployment** — A raw Pod has no self-healing; a Deployment manages ReplicaSets for automatic recovery.

---

## 3. Files in This Task

| File | Purpose |
|------|---------|
| `psql-pvc.yaml` | PersistentVolumeClaim requesting 1Gi of storage |
| `psql-deploy.yaml` | PostgreSQL running as a raw Pod with PVC mount |
| `nginx-deploy.yaml` | Stateless Nginx Deployment with ClusterIP Service |

---

## 4. Step-by-Step Instructions

### Prerequisites
- Minikube cluster running
- `kubectl` configured

### Steps

1. **Create the PVC**
   ```bash
   kubectl apply -f psql-pvc.yaml
   kubectl get pvc
   kubectl get pv
   ```

2. **Deploy PostgreSQL Pod**
   ```bash
   kubectl apply -f psql-deploy.yaml
   kubectl get pods -w
   ```

3. **Verify PostgreSQL has the correct storage**
   ```bash
   kubectl describe pod postgres
   # Look for the Volume section showing the PVC mount
   ```

4. **Deploy Nginx**
   ```bash
   kubectl apply -f nginx-deploy.yaml
   kubectl get pods -w
   ```

5. **Test Nginx connectivity**
   ```bash
   kubectl port-forward service/nginx-service 8080:80
   # Open http://localhost:8080 in browser
   ```

---

## 5. Verification Steps

```bash
# Check all resources
kubectl get pvc
kubectl get pv
kubectl get pods
kubectl get deployments
kubectl get services

# Check PostgreSQL storage details
kubectl describe pod postgres

# Verify data persistence: write data to PostgreSQL
kubectl exec postgres -- psql -U postgres -c "CREATE DATABASE testdb;"
kubectl exec postgres -- psql -U postgres -c "\l"

# Delete the PostgreSQL pod and watch it... wait, it won't come back!
# (This demonstrates why raw Pods are not recommended)
kubectl delete pod postgres
kubectl get pods  # Notice postgres is gone!

# Re-apply the pod
kubectl apply -f psql-deploy.yaml
kubectl get pods  # New pod, but same PVC data persists
```

---

## 6. Common Mistakes

| Mistake | Solution |
|---------|----------|
| **PVC in `Pending` state** | Your cluster may not have a default StorageClass. Check `kubectl get storageclass`. Minikube provides one by default. |
| **Pod stuck in `ContainerCreating`** | The PVC might not be bound. Check `kubectl describe pvc postgres-pvc` for events. |
| **PostgreSQL fails to start** | The `POSTGRES_PASSWORD` environment variable is required. Also, ensure `mountPath` is correct (usually `/var/lib/postgresql/data`). |
| **Permission denied on mounted volume** | PostgreSQL runs as a specific user. The PV/PVC must have correct permissions. Minikube's hostPath provisioner handles this automatically. |
| **Using a raw Pod instead of Deployment** | If the Pod dies, it won't come back. Always use Deployments for production, or StatefulSets for databases. |

---

## 7. Best Practices

- **Always use Deployments or StatefulSets** instead of raw Pods for self-healing.
- **Use StatefulSets for databases** — they provide stable network identities and ordered pod management.
- **Right-size your PVC** — request only what you need. You can't shrink a PVC after creation.
- **Use `ReadWriteOnce` for most databases** — only one pod should write at a time to avoid corruption.
- **Backup your data** — PVCs provide persistence but are not backups. Use volume snapshots or database dumps.

---

## 8. Success Criteria

- [ ] PVC is created and bound to a PV
- [ ] PostgreSQL pod is running and storage is mounted
- [ ] Data written to PostgreSQL persists after pod restart
- [ ] Nginx Deployment and Service are running
- [ ] Nginx is accessible via port-forward
- [ ] Understanding the difference: Pod dies = gone, Deployment pod dies = recreated
