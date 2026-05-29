# Task 11: Block Storage — Persistent Storage

## Task Overview
Learn how to provide **persistent block storage** to pods using PersistentVolumeClaims (PVCs) and understand the difference between stateless and stateful applications in Kubernetes.

## Key Concepts
- **PersistentVolume (PV)**: A piece of storage provisioned in the cluster
- **PersistentVolumeClaim (PVC)**: A request for storage by a user/pod
- **StorageClass**: Defines different types of storage (SSD, HDD, network)
- **Access Modes**: ReadWriteOnce, ReadOnlyMany, ReadWriteMany
- **Dynamic Provisioning**: Kubernetes automatically creates PVs based on PVCs

## Files in This Task

| File | Purpose |
|------|---------|
| `pvc.yaml` | PVC requesting 500Mi of storage |
| `pod.yaml` | Pod that mounts the PVC and writes data |

## Step-by-Step Instructions

### 1. Create the PVC
```bash
kubectl apply -f pvc.yaml
kubectl get pvc
kubectl get pv
```

### 2. Deploy the Pod
```bash
kubectl apply -f pod.yaml
kubectl get pods -w
```

### 3. Write and verify data
```bash
kubectl exec data-pod -- sh -c "echo 'Persistent data' > /data/test.txt"
kubectl exec data-pod -- cat /data/test.txt
```

### 4. Prove persistence
```bash
kubectl delete pod data-pod
kubectl apply -f pod.yaml  # Pod comes back with same data!
kubectl exec data-pod -- cat /data/test.txt  # Data still there
```

## Success Criteria
- [ ] PVC is created and bound to a PV
- [ ] Pod mounts the PVC successfully
- [ ] Data persists after pod deletion and recreation
- [ ] PVC access modes and capacity are correct
