# ==============================================
# Task 12: Health Checks Demo
# Flask app that can report healthy/unhealthy state
# ==============================================
from flask import Flask, jsonify
import os

app = Flask(__name__)

# Global flag to simulate health state
healthy = True

@app.route("/")
def index():
    return jsonify({
        "message": "Health Check Demo",
        "status": "healthy" if healthy else "unhealthy"
    })

@app.route("/healthz")
def healthz():
    """Health check endpoint - called by Docker HEALTHCHECK."""
    if healthy:
        return jsonify({"status": "healthy"}), 200
    else:
        return jsonify({"status": "unhealthy"}), 503

@app.route("/set-healthy")
def set_healthy():
    """Reset the app to healthy state."""
    global healthy
    healthy = True
    return jsonify({"status": "healthy", "message": "App is now healthy"})

@app.route("/set-unhealthy")
def set_unhealthy():
    """Simulate a failure - app becomes unhealthy."""
    global healthy
    healthy = False
    return jsonify({"status": "unhealthy", "message": "App is now unhealthy - Docker will detect this!"})

@app.route("/toggle")
def toggle():
    """Toggle between healthy and unhealthy."""
    global healthy
    healthy = not healthy
    return jsonify({
        "status": "healthy" if healthy else "unhealthy",
        "message": f"Toggled to {'healthy' if healthy else 'unhealthy'}"
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
