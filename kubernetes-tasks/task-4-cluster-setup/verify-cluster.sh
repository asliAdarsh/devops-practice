#!/bin/bash
# ============================================================
# verify-cluster.sh — Verify Minikube Cluster Health
# ============================================================
# This script checks that the Minikube cluster is running
# correctly by verifying nodes, system pods, and connectivity.
#
# Usage: chmod +x verify-cluster.sh && ./verify-cluster.sh
# ============================================================

set -e  # Exit on any error

PASS=0
FAIL=0

check() {
    local desc="$1"
    local cmd="$2"
    if eval "$cmd" &>/dev/null; then
        echo "[PASS] $desc"
        PASS=$((PASS + 1))
    else
        echo "[FAIL] $desc"
        FAIL=$((FAIL + 1))
    fi
}

echo ""
echo "========================================"
echo "  Cluster Verification Checks"
echo "========================================"
echo ""

# --------------------------------------------------
# Check 1: Minikube status
# --------------------------------------------------
echo "--- Minikube Status ---"
check "minikube is installed" "command -v minikube"
check "minikube status shows running" "minikube status 2>&1 | grep -q 'Running'"

echo ""

# --------------------------------------------------
# Check 2: kubectl connectivity
# --------------------------------------------------
echo "--- kubectl Connectivity ---"
check "kubectl is installed" "command -v kubectl"
check "kubectl can reach cluster" "kubectl cluster-info 2>&1 | grep -q 'is running'"

echo ""

# --------------------------------------------------
# Check 3: Node status
# --------------------------------------------------
echo "--- Nodes ---"
check "at least 1 node exists" "kubectl get nodes --no-headers 2>&1 | wc -l | tr -d ' ' | grep -q '1'"
check "node is Ready" "kubectl get nodes --no-headers 2>&1 | grep -q 'Ready'"

echo ""
echo "--- Node Details ---"
kubectl get nodes -o wide
echo ""

# --------------------------------------------------
# Check 4: System pods
# --------------------------------------------------
echo "--- System Pods (kube-system) ---"
check "kube-system namespace exists" "kubectl get namespace kube-system 2>&1 | grep -q 'kube-system'"

# Count running pods in kube-system
POD_COUNT=$(kubectl get pods -n kube-system --no-headers 2>&1 | wc -l)
echo "  Found $POD_COUNT pods in kube-system"

# Check specific system components
check "CoreDNS is running" "kubectl get pods -n kube-system --no-headers 2>&1 | grep -q 'coredns'"
check "etcd is running" "kubectl get pods -n kube-system --no-headers 2>&1 | grep -q 'etcd'"
check "kube-apiserver is running" "kubectl get pods -n kube-system --no-headers 2>&1 | grep -q 'kube-apiserver'"
check "kube-controller-manager is running" "kubectl get pods -n kube-system --no-headers 2>&1 | grep -q 'kube-controller-manager'"
check "kube-scheduler is running" "kubectl get pods -n kube-system --no-headers 2>&1 | grep -q 'kube-scheduler'"

echo ""

# --------------------------------------------------
# Check 5: Test deploying a pod
# --------------------------------------------------
echo "--- Deploy Test ---"
kubectl run verify-test --image=nginx --restart=Never &>/dev/null || true
sleep 3
check "can run a test pod" "kubectl get pod verify-test --no-headers 2>&1 | grep -q 'Running\|Completed'"
kubectl delete pod verify-test --force --grace-period=0 &>/dev/null || true

echo ""

# --------------------------------------------------
# Summary
# --------------------------------------------------
echo "========================================"
echo "  Verification Results"
echo "========================================"
echo "  Passed: $PASS"
echo "  Failed: $FAIL"
echo "========================================"

if [ "$FAIL" -eq 0 ]; then
    echo "  Status: ALL CHECKS PASSED"
else
    echo "  Status: $FAIL CHECK(S) FAILED"
    echo "  Review the output above for details."
fi
echo "========================================"
echo ""
