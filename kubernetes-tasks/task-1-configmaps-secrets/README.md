# Task 1: ConfigMaps & Secrets — The Injector

![Kubernetes](https://img.shields.io/badge/Kubernetes-ConfigMaps%20%26%20Secrets-326CE5?style=flat-square&logo=kubernetes&logoColor=white)

---

## 1. Task Overview

This task teaches you how to **separate configuration from application code** using ConfigMaps and Secrets. You will deploy a MongoDB database and Mongo Express (a web-based admin UI) where:

- **Secrets** hold sensitive data (usernames, passwords) — base64 encoded
- **ConfigMaps** hold non-sensitive configuration (service URLs)
- Both are injected into pods as **environment variables**

---

## 2. Key Concepts

- **Secret** — Stores sensitive data like passwords, API keys, or tokens. Values are base64-encoded (not encrypted by default).
- **ConfigMap** — Stores non-sensitive configuration like URLs, ports, or feature flags.
- **Environment Variable Injection** — Pods read values from Secrets/ConfigMaps using `valueFrom.secretKeyRef` and `valueFrom.configMapKeyRef`.
- **Service Discovery** — Pods communicate within the cluster using Service names as DNS hostnames.
- **Multi-Container Deployments** — Two separate deployments (MongoDB + Mongo Express) that work together.

---

## 3. Files in This Task

| File | Purpose |
|------|---------|
| `secret.yaml` | Base64-encoded MongoDB credentials |
| `configmap.yaml` | MongoDB service URL configuration |
| `mongodb-deployment.yaml` | MongoDB Deployment + ClusterIP Service (port 27017) |
| `mongoexpress-deployment.yaml` | Mongo Express Deployment + LoadBalancer Service (port 8081) |

---

## 4. Step-by-Step Instructions

### Prerequisites
- Minikube cluster running (`minikube status`)
- `kubectl` configured to use the minikube context

### Steps

1. **Create the Secret**
   ```bash
   kubectl apply -f secret.yaml
   kubectl get secrets
   kubectl describe secret mongodb-secret
   ```

2. **Create the ConfigMap**
   ```bash
   kubectl apply -f configmap.yaml
   kubectl get configmaps
   kubectl describe configmap mongodb-configmap
   ```

3. **Deploy MongoDB**
   ```bash
   kubectl apply -f mongodb-deployment.yaml
   kubectl get pods -w
   ```

4. **Deploy Mongo Express**
   ```bash
   kubectl apply -f mongoexpress-deployment.yaml
   kubectl get pods -w
   ```

5. **Access Mongo Express**
   ```bash
   minikube service mongo-express-service
   ```

---

## 5. Verification Steps

```bash
# Check all resources are running
kubectl get pods
kubectl get deployments
kubectl get services
kubectl get secrets
kubectl get configmaps

# Check logs of mongo-express
kubectl logs deployment/mongo-express

# Describe the secret to see metadata
kubectl describe secret mongodb-secret

# Port-forward for direct access
kubectl port-forward service/mongo-express-service 8081:8081
# Then open http://localhost:8081
```

---

## 6. Common Mistakes

| Mistake | Solution |
|---------|----------|
| **Base64 values not decoded properly** | Secret values are base64 encoded. Decode with: `echo "dXNlcm5hbWU=" | base64 --decode` |
| **Typo in `secretKeyRef` name or key** | The `name` must match the Secret metadata.name exactly. The `key` must match a key in the secret's `data` field. |
| **ConfigMap `key` mismatch** | When using `configMapKeyRef`, the `key` field must match a key in the ConfigMap's `data` section. |
| **Service name doesn't match** | Mongo Express connects to `mongodb-service` (from ConfigMap). If the MongoDB Service has a different name, it won't resolve. |
| **Pod stuck in `CrashLoopBackOff`** | Check logs: `kubectl logs pod/mongo-express-xxx` — often a connection issue or invalid credentials. |

---

## 7. Best Practices

- **Never hardcode credentials** in your application code or deployment YAML. Always use Secrets.
- **Use descriptive names** for Secret and ConfigMap keys (e.g., `database_url` instead of `url`).
- **Don't commit raw secrets to Git** — use tools like Helm, Sealed Secrets, or External Secrets Operator for production.
- **Secrets are not encrypted** by default in etcd. Enable encryption at rest for production clusters.
- **Use Namespaces** to isolate configuration for different environments (dev, staging, prod).

---

## 8. Success Criteria

- [ ] Secret is created and contains the expected keys
- [ ] ConfigMap is created with the database URL
- [ ] MongoDB pod is running and ready
- [ ] Mongo Express pod is running and ready
- [ ] Mongo Express web UI is accessible (via port-forward or minikube service)
- [ ] Mongo Express can connect to MongoDB and display databases
- [ ] Deleting and recreating a pod picks up the same Secret/ConfigMap config
