# Task 9: Zero-Downtime — Rolling Updates

## Task Overview
Learn how to perform **rolling updates** in Kubernetes to update your application without downtime. When you change the container image or configuration, Kubernetes gradually replaces old pods with new ones.

## Key Concepts
- **Rolling Update**: Gradually replaces old pods with new ones, maintaining availability
- **maxSurge**: Maximum number of extra pods during update (default 25%)
- **maxUnavailable**: Maximum number of pods that can be down during update (default 25%)
- **Rollback**: Revert to the previous version if something goes wrong
- **kubectl rollout**: Commands to manage deployment updates

## Files in This Task

| File | Purpose |
|------|---------|
| `deployment-v1.yaml` | Initial version of the app |
| `deployment-v2.yaml` | Updated version to roll out |

## Step-by-Step Instructions

### 1. Deploy version 1
```bash
kubectl apply -f deployment-v1.yaml
kubectl rollout status deployment/web-app
```

### 2. Update to version 2
```bash
kubectl apply -f deployment-v2.yaml
kubectl rollout status deployment/web-app  # Watch rolling update
```

### 3. Check rollout history
```bash
kubectl rollout history deployment/web-app
```

### 4. Rollback if needed
```bash
kubectl rollout undo deployment/web-app
```

## Success Criteria
- [ ] Initial deployment creates pods with v1 image
- [ ] Rolling update replaces pods with v2 image without downtime
- [ ] Rollout history shows revision changes
- [ ] Rollback successfully reverts to v1
