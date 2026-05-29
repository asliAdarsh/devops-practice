# Task 2: Python FastAPI Application

This task demonstrates how to containerize a Python FastAPI web application.

## Overview

- **Application:** FastAPI web server with Uvicorn
- **Base Image:** Official Python image
- **Port:** 8000
- **Framework:** FastAPI with async support

## Files

- `app.py` - FastAPI application
- `requirements.txt` - Python dependencies
- `dockerfile` - Container configuration

## How to Run

### Build the Docker Image
```bash
docker build -t fastapi-app .
```

### Run the Container
```bash
docker run -p 8000:8000 --name fastapi-container fastapi-app
```

### Test the Application

#### Using curl
```bash
curl http://localhost:8000
```

#### Using browser
Navigate to `http://localhost:8000` in your web browser

#### API Documentation
FastAPI automatically provides interactive API docs at:
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

## Development

### Install Dependencies Locally
```bash
pip install -r requirements.txt
```

### Run Locally
```bash
python app.py
```

### Install Additional Dependencies for Development
```bash
pip install fastapi[all]
```

## API Endpoints

- `GET /` - Returns a welcome message

## Clean Up

Stop and remove the container:
```bash
docker stop fastapi-container
docker rm fastapi-container
```

Remove the image:
```bash
docker rmi fastapi-app
```
