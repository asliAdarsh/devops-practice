# Task 1: Node.js Application with Security Best Practices

This task demonstrates how to containerize a Node.js Express application following security best practices.

## Overview

- **Application:** Simple Express.js server
- **Base Image:** `node:20-alpine` (lightweight Alpine Linux)
- **Security:** Runs as non-root user
- **Port:** 3000

## Files

- `index.js` - Express.js application
- `package.json` - Node.js dependencies
- `dockerfile` - Container configuration with security practices

## How to Run

### Build the Docker Image
```bash
docker build -t node-secure-app .
```

### Run the Container
```bash
docker run -p 3000:3000 --name node-app node-secure-app
```

### Test the Application
Open your browser or use curl:
```bash
curl http://localhost:3000
```

## Security Features Demonstrated

1. **Non-root User:** Application runs as `appuser` instead of root
2. **Minimal Base Image:** Uses Alpine Linux for reduced attack surface
3. **Proper File Ownership:** Files owned by application user
4. **Least Privilege:** Only necessary permissions granted

## Development

### Install Dependencies Locally
```bash
npm install
```

### Run Locally
```bash
npm start
```

## Clean Up

Stop and remove the container:
```bash
docker stop node-app
docker rm node-app
```

Remove the image:
```bash
docker rmi node-secure-app
```
