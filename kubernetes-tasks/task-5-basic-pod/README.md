# Task 5: Basic Pod — The Manual Pod

![Kubernetes](https://img.shields.io/badge/Kubernetes-Basic%20Pod-326CE5?style=flat-square&logo=kubernetes&logoColor=white)

---

## 1. Task Overview

This task teaches you the **smallest deployable unit in Kubernetes — a Pod**. You will:

- Write a YAML file to define a simple nginx pod
- Learn the structure of Kubernetes YAML (apiVersion, kind, metadata, spec)
- Deploy, inspect, and delete a pod
- View container logs
- Understand the pod lifecycle

This is the building block for everything else in Kubernetes.

---

## 2. Key Concepts

- **Pod** — The smallest deployable unit in Kubernetes. A pod wraps one or more containers that share network and storage.
- **YAML Structure** — Every Kubernetes resource follows the same top-level structure:
  - `apiVersion` — Which version of the Kubernetes API to use (e.g., `v1` for core resources)
  - `kind` — The type of resource (e.g., `Pod`, `Service`, `Deployment`)
  - `metadata` — Name, labels, annotations, namespace
  - `spec` — The desired state (e.g., which containers, ports, volumes)
- **Container** — A running instance of an OCI image (Docker image). Pods typically run one main container.
- **Pod Lifecycle** — Pending → Running → Succeeded/Failed/CrashLoopBackOff
- **Imperative vs Declarative** — `kubectl run` is imperative (do this now); `kubectl apply -f pod.yaml` is declarative (make this the current state).

---

## 3. Files in This Task

| File | Purpose |
|------|---------|
| `pod.yaml` | A simple nginx pod definition with detailed YAML comments |

---

## 4. Step-by-Step Instructions

### Prerequisites
- Minikube cluster running (`minikube status`)
- `kubectl` configured

### Steps

1. **Read the pod.yaml file** to understand each field
   ```bash
   cat pod.yaml
   ```

2. **Create the pod**
   ```bash
   kubectl apply -f pod.yaml
   ```

3. **List pods**
   ```bash
   kubectl get pods
   kubectl get pods -o wide   # Shows node and IP
   kubectl get pods -o yaml   # Shows full YAML definition
   ```

4. **Describe the pod** (detailed status and events)
   ```bash
   kubectl describe pod my-first-pod
   ```

5. **View container logs**
   ```bash
   kubectl logs my-first-pod
   ```

6. **Execute a command inside the pod**
   ```bash
   kubectl exec my-first-pod -- curl localhost
   ```

7. **Delete the pod**
   ```bash
   kubectl delete pod my-first-pod
   # Or delete using the file
   kubectl delete -f pod.yaml
   ```

---

## 5. Verification Steps

```bash
# Pod should show STATUS "Running"
kubectl get pods

# Check the IP address assigned to the pod
kubectl get pods -o wide

# Describe shows events (pulled image, created container, started)
kubectl describe pod my-first-pod

# Logs should show nginx startup messages
kubectl logs my-first-pod

# Curl from inside the pod should return nginx welcome page
kubectl exec my-first-pod -- curl -s http://localhost | head -5

# After delete, verify it's gone
kubectl get pods
```

---

## 6. Common Mistakes

| Mistake | Solution |
|---------|----------|
| **Pod stuck in `Pending`** | Usually means the image can't be pulled. Check `kubectl describe pod my-first-pod` for events. |
| **Wrong `apiVersion`** | For core resources like Pod, Service, ConfigMap, Secret, use `apiVersion: v1`. For Deployments, use `apps/v1`. |
| **Missing `name` in metadata** | Every resource must have a name. Names must be unique within a namespace. |
| **Typos in `kind`** | `kind` is case-sensitive. `pod` (lowercase) won't work; use `Pod`. |
| **Pod doesn't restart after delete** | Raw Pods don't self-heal! That's why Deployments exist (see Task 6). |

---

## 7. Best Practices

- **Always use `kubectl apply -f`** instead of `kubectl create -f`. `apply` allows declarative updates later.
- **Use labels** to organize your pods. `metadata.labels.app: myapp` helps Services find the right pods.
- **Never run raw Pods in production** — use Deployments, StatefulSets, or DaemonSets instead.
- **Use `kubectl explain`** to understand any resource field: `kubectl explain pod`, `kubectl explain pod.spec.containers`.
- **Keep containers focused** — one container per pod for most cases. Sidecar containers are the exception.

---

## 8. Success Criteria

- [ ] `pod.yaml` is created with correct apiVersion, kind, metadata, and spec
- [ ] Pod is created and shows STATUS "Running"
- [ ] `kubectl describe pod` shows container details and events
- [ ] `kubectl logs` shows nginx startup logs
- [ ] You can exec into the pod and run commands
- [ ] Pod is successfully deleted
