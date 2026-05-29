#!/usr/bin/env python3
# ==============================================
# Task 17: Docker Swarm Demo - Web App
# Displays hostname and replica info
# ==============================================
from flask import Flask, jsonify
import socket
import os

app = Flask(__name__)

@app.route("/")
def index():
    """Return container and swarm info."""
    hostname = socket.gethostname()
    return jsonify({
        "message": "Hello from Docker Swarm!",
        "hostname": hostname,
        "node": os.uname().nodename,
        "replica": os.environ.get("DOCKER_SERVICE_ID", "unknown"),
        "version": "1.0.0"
    })

@app.route("/health")
def health():
    """Health check endpoint."""
    return jsonify({"status": "healthy", "hostname": socket.gethostname()})

@app.route("/version")
def version():
    """Return the app version."""
    return jsonify({"version": "1.0.0"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
