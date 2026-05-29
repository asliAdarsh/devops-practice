# Task 8: The Scalable One — Horizontal Scaling

## Task Overview
Learn how to **scale applications horizontally** in Kubernetes by increasing the number of pod replicas in a Deployment, and understand how Services distribute traffic across them.

## Key Concepts
- **Replicas**: Number of identical pod instances running the same application
- **Horizontal Scaling**: Adding more pods to handle increased load
- **kubectl scale**: Command to change replica count manually
- **Rolling Update Strategy**: Default strategy for updating pods without downtime
- **Service Load Balancing**: A Service distributes traffic across all replica pods

## Files in This Task

| File | Purpose |
|------|---------|
| `deployment.yaml` | Deployment with configurable replicas |
| `service.yaml` | ClusterIP Service to distribute traffic |

## Step-by-Step Instructions

### 1. Deploy the application
```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

### 2. Scale up
```bash
kubectl scale deployment web-app --replicas=5
kubectl get pods -w  # Watch new pods being created
```

### 3. Verify traffic distribution
```bash
# Run multiple requests to see different pods responding
for i in $(seq 1 10); do curl http://localhost:8080; done
```

## Success Criteria
- [ ] Initial deployment runs with 3 replicas
- [ ] Scaling to 5 replicas creates 2 additional pods
- [ ] Service distributes traffic across all replicas
- [ ] Scaling down removes pods gracefully
