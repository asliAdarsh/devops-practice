# Task 4: Cluster Setup — The First Breath

![Kubernetes](https://img.shields.io/badge/Kubernetes-Cluster%20Setup-326CE5?style=flat-square&logo=kubernetes&logoColor=white)

---

## 1. Task Overview

This task teaches you how to **set up a local Kubernetes cluster** from scratch using Minikube. You will:

- Install Minikube and kubectl
- Start a single-node Kubernetes cluster
- Verify the cluster is healthy
- Learn what kubectl and Minikube are and how they work together

This is the foundation for ALL subsequent tasks. Complete this first.

---

## 2. Key Concepts

- **Kubernetes (K8s)** — An open-source platform for automating deployment, scaling, and management of containerized applications.
- **Minikube** — A tool that runs a single-node Kubernetes cluster on your local machine (uses a VM or Docker).
- **kubectl** — The command-line tool for interacting with Kubernetes clusters. Pronounced "kube-control" or "kube-C-T-L".
- **Cluster** — A set of nodes (machines) that run containerized applications managed by Kubernetes.
- **Node** — A worker machine (physical or virtual) in Kubernetes. Minikube creates one node.
- **Context** — The cluster that `kubectl` is currently configured to talk to. Check with `kubectl config current-context`.

### What's the difference?

| Tool | Purpose |
|------|---------|
| **Minikube** | Creates and manages a local K8s cluster (one node, runs in a container or VM) |
| **kubectl** | CLI to deploy apps, inspect resources, and manage any K8s cluster (local or remote) |
| **Docker** | Container runtime that runs the actual containers inside pods |
| **Kubelet** | The agent running on each node that ensures containers are running |

---

## 3. Files in This Task

| File | Purpose |
|------|---------|
| `install-minikube.sh` | Script to install Minikube and start a cluster |
| `verify-cluster.sh` | Script to verify the cluster is running correctly |

---

## 4. Step-by-Step Instructions

### Steps

1. **Install kubectl** (if not already installed)
   ```bash
   # Linux
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   chmod +x kubectl
   sudo mv kubectl /usr/local/bin/

   # macOS
   brew install kubectl

   # Windows (using Chocolatey)
   choco install kubernetes-cli
   ```

2. **Run the Minikube installation script**
   ```bash
   chmod +x install-minikube.sh
   ./install-minikube.sh
   ```

3. **Verify the cluster**
   ```bash
   chmod +x verify-cluster.sh
   ./verify-cluster.sh
   ```

4. **Explore kubectl commands**
   ```bash
   # Get cluster info
   kubectl cluster-info

   # Check kubectl configuration
   kubectl config view
   kubectl config current-context

   # List all nodes
   kubectl get nodes -o wide
   ```

---

## 5. Verification Steps

```bash
# Check cluster is running
kubectl cluster-info

# Check nodes are ready
kubectl get nodes

# Check all system pods are running
kubectl get pods -A

# Check Minikube status
minikube status

# Test by running a simple pod
kubectl run test-pod --image=nginx --restart=Never
kubectl get pods
kubectl delete pod test-pod
```

**Expected Output:**
```
kubectl cluster-info → Shows Kubernetes master and CoreDNS URLs
kubectl get nodes → Shows one node named "minikube" with STATUS "Ready"
kubectl get pods -A → Shows system pods (kube-system, coredns, etcd, etc.)
minikube status → Shows "host: Running", "kubelet: Running", "apiserver: Running"
```

---

## 6. Common Mistakes

| Mistake | Solution |
|---------|----------|
| **"minikube: command not found"** | Make sure `~/.local/bin` (or the install path) is in your PATH. Restart your terminal. |
| **"kubectl: command not found"** | Kubectl must be installed separately. Follow the install instructions above. |
| **Minikube fails to start with driver errors** | Try `minikube start --driver=docker` (requires Docker Desktop). On Linux, you might need `--driver=none`. |
| **"Unable to connect to the server: dial tcp"** | Minikube might not be running. Check `minikube status` and restart with `minikube start`. |
| **Insufficient resources (RAM/CPU)** | Minikube default needs 2 CPUs and 2GB RAM. Use `minikube start --cpus=4 --memory=4096` to set more. |
| **Windows: Hyper-V vs Docker driver issues** | On Windows, Docker Desktop driver works best. Try `minikube start --driver=docker`. |

---

## 7. Best Practices

- **Use a dedicated terminal window** for Minikube commands — it logs useful info to stdout.
- **Set the default driver** with `minikube config set driver docker` to avoid typing `--driver` every time.
- **Monitor resource usage** — Minikube can consume significant CPU/RAM. Stop it when not in use: `minikube stop`.
- **Use `minikube dashboard`** to launch a web-based UI for your cluster.
- **Don't run production workloads** on Minikube. It's designed for learning and development only.

---

## 8. Success Criteria

- [ ] Minikube is installed (`minikube version` returns a version)
- [ ] kubectl is installed (`kubectl version --client` returns a version)
- [ ] Minikube cluster is running (`minikube status` shows all components as "Running")
- [ ] `kubectl get nodes` shows "Ready" status
- [ ] `kubectl get pods -A` shows all system pods running
- [ ] You can run a simple nginx pod on the cluster
- [ ] You understand the difference between kubectl and Minikube
