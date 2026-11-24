
from flask import Flask, jsonify
from datetime import datetime, timezone
import os

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "application": "AWS EKS GitOps Platform",
        "status": "running",
        "message": "Hello from Kubernetes!",
        "environment": os.getenv("APP_ENV", "development"),
        "timestamp": datetime.now(timezone.utc).isoformat()
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200

@app.route("/ready")
def ready():
    return jsonify({"status": "ready"}), 200

@app.route("/info")
def info():
    return jsonify({
        "application": "aws-eks-gitops-platform",
        "version": os.getenv("APP_VERSION", "1.0.0"),
        "environment": os.getenv("APP_ENV", "development")
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
