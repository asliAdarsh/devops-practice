# Task 3: Ingress — The Traffic Cop

![Kubernetes](https://img.shields.io/badge/Kubernetes-Ingress-326CE5?style=flat-square&logo=kubernetes&logoColor=white)

---

## 1. Task Overview

This task teaches you how to **route external HTTP/HTTPS traffic to multiple services** inside the cluster using a single Ingress resource. You will:

- Configure path-based routing rules
- Route `/` traffic to a frontend service
- Route `/api/` traffic to a backend service
- Use the `rewrite-target` annotation for URL rewriting

---

## 2. Key Concepts

- **Ingress** — A Kubernetes resource that manages external access to services, typically HTTP/HTTPS.
- **Ingress Controller** — A pod (like nginx-ingress) that implements the Ingress rules. The Ingress resource is just a config; the controller does the actual routing.
- **Path-Based Routing** — Directing traffic to different services based on the URL path (e.g., `/api/` → backend, `/` → frontend).
- **Annotations** — Additional configuration for the Ingress controller (e.g., `nginx.ingress.kubernetes.io/rewrite-target`).
- **Rewrite Target** — Strips or modifies the path prefix before forwarding to the backend service.

---

## 3. Files in This Task

| File | Purpose |
|------|---------|
| `ingress-deploy.yaml` | Ingress resource with path-based routing rules |

---

## 4. Step-by-Step Instructions

### Prerequisites
- Minikube cluster running
- `kubectl` configured
- Ingress controller enabled in minikube

### Steps

1. **Enable the Ingress Controller in Minikube**
   ```bash
   minikube addons enable ingress
   kubectl get pods -n ingress-nginx  # Wait for controller to be ready
   ```

2. **Deploy a Frontend Service** (example: a simple web app)
   ```bash
   kubectl create deployment frontend --image=nginx
   kubectl expose deployment frontend --port=80 --target-port=80
   ```

3. **Deploy a Backend Service** (example: a simple API)
   ```bash
   kubectl create deployment backend --image=nginx
   kubectl expose deployment backend --port=80 --target-port=80
   ```

4. **Apply the Ingress Resource**
   ```bash
   kubectl apply -f ingress-deploy.yaml
   kubectl get ingress
   ```

5. **Test Path-Based Routing**
   ```bash
   # Get the minikube IP
   minikube ip

   # Add an entry to your hosts file (/etc/hosts on Linux/Mac, C:\Windows\System32\drivers\etc\hosts on Windows)
   # <minikube-ip> myapp.local

   # Test routing
   curl http://myapp.local/      # Should hit frontend
   curl http://myapp.local/api/  # Should hit backend
   ```

---

## 5. Verification Steps

```bash
# Check ingress status
kubectl get ingress
kubectl describe ingress

# Check ingress-nginx controller logs
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller

# Verify the rewrite annotation is working
curl -v http://myapp.local/api/
# The backend should receive `/` not `/api/`

# Test without hosts file using port-forward
kubectl port-forward -n ingress-nginx service/ingress-nginx-controller 8080:80 &
curl -H "Host: myapp.local" http://localhost:8080/
curl -H "Host: myapp.local" http://localhost:8080/api/
```

---

## 6. Common Mistakes

| Mistake | Solution |
|---------|----------|
| **Ingress controller not running** | `minikube addons enable ingress` and wait for the controller pod to be ready. |
| **No Ingress resource `host` field set** | If `host` is not specified, the ingress matches all hosts. Specifying a host is recommended for production. |
| **Backend Service doesn't exist** | The Ingress rule references `service.name` and `service.port.` Ensure those Services exist. |
| **`rewrite-target` not working** | The annotation must be `nginx.ingress.kubernetes.io/rewrite-target: /`. Without it, the backend receives the full path. |
| **HTTPS without TLS config** | The Ingress won't automatically serve HTTPS. You need to configure TLS certificates in the Ingress spec. |

---

## 7. Best Practices

- **Always specify a `host` field** in production to avoid accidentally routing traffic meant for other services.
- **Use TLS certificates** for production ingress. Use Let's Encrypt with cert-manager for automatic certificates.
- **Keep ingress rules simple** — complex routing logic is harder to debug. Split into multiple ingress resources if needed.
- **Monitor the Ingress Controller** — it's a critical piece of infrastructure. Monitor its health and logs.
- **Use `rewrite-target` carefully** — ensure your backend can handle the rewritten path.

---

## 8. Success Criteria

- [ ] Ingress controller is running (ingress-nginx pods in `ingress-nginx` namespace)
- [ ] Frontend and backend Services exist and are running
- [ ] Ingress resource is created and shows the configured rules
- [ ] `curl http://myapp.local/` returns frontend content
- [ ] `curl http://myapp.local/api/` returns backend content
- [ ] Backend receives `/` (not `/api/`) due to rewrite-target
- [ ] Understanding how path-based routing differs from host-based routing
