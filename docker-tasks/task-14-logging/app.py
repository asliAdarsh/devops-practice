import time
import json
import sys
import random

methods = ["GET", "POST", "PUT", "DELETE"]
paths = ["/api/users", "/api/orders", "/api/products", "/health"]
codes = [200, 200, 200, 200, 201, 404, 500]

while True:
    log = {
        "timestamp": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "method": random.choice(methods),
        "path": random.choice(paths),
        "status": random.choice(codes),
        "duration_ms": random.randint(10, 500)
    }
    print(json.dumps(log))
    sys.stdout.flush()
    time.sleep(1)
