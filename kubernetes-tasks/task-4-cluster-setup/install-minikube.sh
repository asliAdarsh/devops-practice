#!/bin/bash
# ============================================================
# install-minikube.sh — Minikube Installation & Cluster Start
# ============================================================
# This script installs Minikube (if not present) and starts
# a single-node Kubernetes cluster.
#
# Usage: chmod +x install-minikube.sh && ./install-minikube.sh
# ============================================================

set -e  # Exit on any error

echo "========================================"
echo "  Minikube Installation & Cluster Start"
echo "========================================"

# --------------------------------------------------
# Step 1: Check if Minikube is already installed
# --------------------------------------------------
if command -v minikube &> /dev/null; then
    echo "[OK] Minikube is already installed: $(minikube version)"
else
    echo "[INFO] Minikube not found. Installing..."

    # Detect OS and install accordingly
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)

    if [ "$OS" = "linux" ]; then
        # Linux installation
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-$ARCH
        sudo install minikube-linux-$ARCH /usr/local/bin/minikube
        rm minikube-linux-$ARCH
    elif [ "$OS" = "darwin" ]; then
        # macOS installation
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-$ARCH
        sudo install minikube-darwin-$ARCH /usr/local/bin/minikube
        rm minikube-darwin-$ARCH
    else
        echo "[ERROR] Unsupported OS: $OS"
        echo "  Please install Minikube manually:"
        echo "  https://minikube.sigs.k8s.io/docs/start/"
        exit 1
    fi

    echo "[OK] Minikube installed successfully: $(minikube version)"
fi

# --------------------------------------------------
# Step 2: Check if kubectl is installed
# --------------------------------------------------
if command -v kubectl &> /dev/null; then
    echo "[OK] kubectl is installed: $(kubectl version --client 2>/dev/null || kubectl version)"
else
    echo "[WARN] kubectl is not installed."
    echo "  Please install kubectl manually:"
    echo "  https://kubernetes.io/docs/tasks/tools/"
    echo ""
    echo "  Quick install with curl:"
    echo "  curl -LO \"https://dl.k8s.io/release/\$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl\""
    echo "  chmod +x kubectl && sudo mv kubectl /usr/local/bin/"
fi

# --------------------------------------------------
# Step 3: Check for a container driver (Docker)
# --------------------------------------------------
if command -v docker &> /dev/null; then
    echo "[OK] Docker is available — will use docker driver"
    DRIVER="docker"
else
    echo "[WARN] Docker not found. Will try default driver."
    DRIVER="auto"
fi

# --------------------------------------------------
# Step 4: Start Minikube cluster
# --------------------------------------------------
echo ""
echo "[INFO] Starting Minikube cluster..."
echo "  Driver: $DRIVER"
echo "  CPUs:   2"
echo "  Memory: 2048 MB"
echo ""

if [ "$DRIVER" = "docker" ]; then
    minikube start --driver=docker --cpus=2 --memory=2048
else
    minikube start --cpus=2 --memory=2048
fi

# --------------------------------------------------
# Step 5: Verify cluster is running
# --------------------------------------------------
echo ""
echo "[INFO] Verifying cluster..."
echo ""

# Check nodes
echo "--- Nodes ---"
kubectl get nodes -o wide

# Check system pods
echo ""
echo "--- System Pods (kube-system) ---"
kubectl get pods -n kube-system

echo ""
echo "========================================"
echo "  Cluster is ready!"
echo "========================================"
echo ""
echo "  Run 'minikube dashboard' for web UI"
echo "  Run 'minikube stop' to stop cluster"
echo "  Run './verify-cluster.sh' for detailed check"
echo "========================================"
