# Task 5: Create React App with Multi-Stage Build

This task demonstrates how to containerize a Create React App application using multi-stage Docker builds for production deployment.

## Overview

- **Frontend:** React application created with Create React App
- **Build Stage:** Node.js environment for building the app
- **Production Stage:** Nginx serving static files
- **Port:** 80

## Multi-Stage Architecture

```
┌─────────────────┐    ┌─────────────────┐
│   Builder Stage │───▶│ Production Stage│
│   (Node.js)     │    │   (Nginx)       │
│  - npm install  │    │  - Static files │
│  - npm run build│    │  - SPA routing  │
└─────────────────┘    └─────────────────┘
```

## Files

- `src/` - React application source code
- `public/` - Static assets
- `package.json` - Dependencies and build scripts
- `dockerfile` - Multi-stage build configuration

## How to Run

### Build the Docker Image
```bash
docker build -t cra-react-app .
```

### Run the Container
```bash
docker run -p 80:80 --name cra-react-container cra-react-app
```

### Access the Application
Open your browser and navigate to: `http://localhost`

## Development

### Install Dependencies
```bash
npm install
```

### Run Development Server
```bash
npm start
```

### Build for Production Locally
```bash
npm run build
```

### Run Tests
```bash
npm test
```

## Docker Multi-Stage Build Benefits

1. **Smaller Final Image:** Only Nginx and built files, no Node.js
2. **Improved Security:** No build tools in production
3. **Better Performance:** Optimized static file serving
4. **Clean Separation:** Build and runtime concerns separated

## Build Process

1. **Stage 1 (Builder):**
   - Install dependencies
   - Build React application with Create React App
   - Output: `/app/build` directory

2. **Stage 2 (Production):**
   - Copy built files from builder stage
   - Serve static content with Nginx

## Available Scripts

### `npm start`
Runs the app in development mode on `http://localhost:3000`

### `npm test`
Launches the test runner in interactive watch mode

### `npm run build`
Builds the app for production to the `build` folder

### `npm run eject`
**One-way operation** - removes the single build dependency and copies all configuration files

## Clean Up

Stop and remove the container:
```bash
docker stop cra-react-container
docker rm cra-react-container
```

Remove the image:
```bash
docker rmi cra-react-app
```

## Troubleshooting

### Check Build Output
```bash
docker run --rm -it cra-react-app ls -la /usr/share/nginx/html
```

### Access Container Shell
```bash
docker run -it --rm cra-react-app sh
```

### View Nginx Logs
```bash
docker logs cra-react-container
```

## Learn More

- [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started)
- [React documentation](https://reactjs.org/)
