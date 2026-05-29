# Task 7: Service Discovery — The DNS Navigator

## Task Overview
Learn how Kubernetes **Services** enable automatic DNS-based service discovery within the cluster. Containers can find each other using service names instead of hardcoded IP addresses.

## Key Concepts
- **ClusterIP Service**: Default service type; exposes a stable virtual IP within the cluster
- **DNS Resolution**: Kubernetes DNS resolves service names to ClusterIPs
- **kube-dns / CoreDNS**: Built-in DNS server that creates DNS records for Services
- **Service Naming**: Services are accessible as `<service-name>.<namespace>.svc.cluster.local`
- **Environment Variables**: Kubernetes also injects service info as env vars (less reliable)

## Files in This Task

| File | Purpose |
|------|---------|
| `frontend-deployment.yaml` | Deployment that pings the backend service |
| `backend-deployment.yaml` | Backend Deployment with a ClusterIP Service |
| `backend-service.yaml` | ClusterIP Service for DNS discovery |

## Step-by-Step Instructions

### 1. Deploy the backend
```bash
kubectl apply -f backend-deployment.yaml
kubectl apply -f backend-service.yaml
```

### 2. Deploy the frontend
```bash
kubectl apply -f frontend-deployment.yaml
```

### 3. Verify DNS resolution
```bash
# Exec into frontend pod and ping backend by service name
kubectl exec deployment/frontend -- nslookup backend-service
kubectl exec deployment/frontend -- curl http://backend-service:80
```

## Verification Steps
- [ ] Backend Service is created and shows a ClusterIP
- [ ] Frontend pod can resolve `backend-service` via DNS
- [ ] HTTP request to `backend-service` succeeds
- [ ] `kubectl get svc` shows the ClusterIP

## Success Criteria
- [ ] DNS resolution works for service names
- [ ] Frontend can communicate with backend via service name
- [ ] Service discovery without hardcoded IPs is demonstrated
