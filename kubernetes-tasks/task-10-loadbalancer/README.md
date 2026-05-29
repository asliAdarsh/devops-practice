# Task 10: LoadBalancer — The Public Face

## Task Overview
Learn how to expose Kubernetes applications to the internet using a **LoadBalancer Service** type. This creates an external load balancer with a public IP that distributes incoming traffic to your pods.

## Key Concepts
- **LoadBalancer Service**: Exposes a Service externally using a cloud provider's load balancer
- **External IP**: The Service gets a public IP address accessible from outside the cluster
- **NodePort Fallback**: In Minikube, LoadBalancer type falls back to NodePort
- **minikube tunnel**: Required to assign external IPs in Minikube
- **Session Affinity**: Stickiness to route same client to the same pod

## Files in This Task

| File | Purpose |
|------|---------|
| `deployment.yaml` | Web application Deployment |
| `service.yaml` | LoadBalancer Service configuration |

## Step-by-Step Instructions

### 1. Deploy the application
```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

### 2. Expose in Minikube
```bash
# In a separate terminal, run:
minikube tunnel

# Then get the external IP:
kubectl get svc web-service
```

### 3. Access the application
```bash
# Once the external IP is assigned (usually localhost in Minikube):
curl http://localhost
```

## Success Criteria
- [ ] LoadBalancer Service is created
- [ ] External IP is assigned (via minikube tunnel)
- [ ] Application is accessible from outside the cluster
- [ ] Traffic is distributed across pod replicas
