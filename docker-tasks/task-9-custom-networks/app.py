# ==============================================
# Simple Flask API for the custom networks demo
# Returns a response showing which network it's on
# ==============================================
from flask import Flask, jsonify
import socket
import os

app = Flask(__name__)

@app.route("/")
def index():
    """Return container and network info."""
    hostname = socket.gethostname()
    return jsonify({
        "message": "Hello from the API service!",
        "hostname": hostname,
        "networks": ["frontend_network", "backend_network"],
        "status": "connected to both frontend and backend networks"
    })

@app.route("/health")
def health():
    """Health check endpoint."""
    return jsonify({"status": "healthy"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
