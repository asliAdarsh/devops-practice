# Task 6: Deployment & Self-Healing — The Manager

![Kubernetes](https://img.shields.io/badge/Kubernetes-Deployment%20%26%20Self%20Healing-326CE5?style=flat-square&logo=kubernetes&logoColor=white)

---

## 1. Task Overview

This task teaches you **how Deployments manage pods and keep them running**. Unlike raw Pods (Task 5), a Deployment automatically replaces failed pods. You will:

- Create an Nginx Deployment with 3 replicas
- Add a liveness probe for health checking
- Kill a pod and watch Kubernetes recreate it
- Learn about ReplicaSets and the reconciliation loop

---

## 2. Key Concepts

- **Deployment** — A higher-level resource that manages ReplicaSets and provides declarative updates (rolling updates, rollbacks).
- **ReplicaSet** — Ensures a specified number of pod replicas are running at all times. The Deployment creates and manages ReplicaSets.
- **Reconciliation Loop** — The controller constantly checks: "Is the current state matching the desired state?" If not, it takes action.
- **Liveness Probe** — A health check that tells Kubernetes when to restart a container (if the app is stuck or deadlocked).
- **Readiness Probe** — A health check that tells Kubernetes when a pod is ready to receive traffic.
- **Self-Healing** — When a pod dies, the ReplicaSet notices the desired count isn't met and creates a new pod.

---

## 3. Files in This Task

| File | Purpose |
|------|---------|
| `deployment.yaml` | Nginx Deployment with 3 replicas and liveness probe |

---

## 4. Step-by-Step Instructions

### Prerequisites
- Minikube cluster running
- `kubectl` configured

### Steps

1. **Create the Deployment**
   ```bash
   kubectl apply -f deployment.yaml
   ```

2. **Watch pods come up**
   ```bash
   kubectl get pods -w
   ```
   Press Ctrl+C to exit watch mode.

3. **Inspect the Deployment and ReplicaSet**
   ```bash
   # Show deployment details
   kubectl get deployments
   kubectl describe deployment nginx-deployment

   # Show the ReplicaSet created by the Deployment
   kubectl get replicasets
   kubectl describe replicaset
   ```

4. **Test Self-Healing — delete a pod!**
   ```bash
   # Get the name of one pod
   kubectl get pods

   # Delete one pod
   kubectl delete pod nginx-deployment-xxxxx

   # Watch the ReplicaSet create a new one immediately
   kubectl get pods -w
   ```

5. **Verify the new pod is different**
   ```bash
   # The old pod is gone, a new one with a different name exists
   kubectl get pods
   ```

6. **Scale the Deployment**
   ```bash
   # Scale to 5 replicas
   kubectl scale deployment nginx-deployment --replicas=5
   kubectl get pods -w

   # Scale back to 3
   kubectl scale deployment nginx-deployment --replicas=3
   kubectl get pods -w
   ```

---

## 5. Verification Steps

```bash
# Check deployment status
kubectl get deployments
kubectl describe deployment nginx-deployment

# Check ReplicaSet
kubectl get replicasets

# Check all pods are running
kubectl get pods

# Verify liveness probe is working (check events)
kubectl describe pod nginx-deployment-xxxxx | grep -A5 Events

# Scale up and down
kubectl scale deployment nginx-deployment --replicas=5
kubectl get pods
kubectl scale deployment nginx-deployment --replicas=3

# Delete a pod and verify self-healing
POD_NAME=$(kubectl get pods -o name | head -1)
kubectl delete $POD_NAME
sleep 3
kubectl get pods   # New pod should appear
```

---

## 6. Common Mistakes

| Mistake | Solution |
|---------|----------|
| **Liveness probe failing causes restart loop** | If the probe endpoint doesn't exist, the pod restarts repeatedly. Make sure the probe path matches what the app serves. |
| **Deployment stuck scaling down** | Check for a `PodDisruptionBudget` or finalizers: `kubectl get pods --all-namespaces | grep Terminating` |
| **Forgetting `selector.matchLabels`** | The Deployment's `spec.selector.matchLabels` must match the pod template's `metadata.labels`. This is immutable after creation. |
| **Deleting a pod manually doesn't cause downtime** | The ReplicaSet creates a new pod, but there's a brief moment with fewer pods. Use `maxSurge` and `maxUnavailable` to control this. |
| **Wrong image name causes CrashLoopBackOff** | `kubectl describe pod` shows the error. Fix the image name and `kubectl apply -f deployment.yaml` again. |

---

## 7. Best Practices

- **Add both liveness and readiness probes** — liveness for restart, readiness for traffic routing. They serve different purposes.
- **Set resource requests and limits** — prevents pods from consuming all node resources and helps the scheduler place them.
- **Use `kubectl apply` not `kubectl create deployment`** — declarative management via YAML is reproducible and reviewable.
- **Label your resources** — consistent labels (`app`, `tier`, `env`) help Services, NetworkPolicies, and monitoring tools find the right pods.
- **Never edit running deployments directly** — always update the YAML and re-apply. This ensures your source of truth is in files.

---

## 8. Success Criteria

- [ ] Deployment is created with 3 replicas
- [ ] All 3 pods are running and ready
- [ ] A ReplicaSet was automatically created
- [ ] Deleting a pod results in a new pod being created (self-healing)
- [ ] Scaling the deployment adds/removes pods as expected
- [ ] Liveness probe is configured and working
- [ ] You understand the difference between Pod (Task 5) and Deployment
