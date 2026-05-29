# Task 1: Static Content — The Doorman

This task demonstrates basic Nginx static file serving using Docker.

## Overview
- Serve a simple HTML page using Nginx inside a Docker container
- Build a custom Nginx image with `nginx:alpine` base
- Copy static assets to Nginx's default web root

## Files
- `dockerfile` — Custom Nginx image with static HTML
- `index.html` — Interactive HTML page with button click counter

## Run
```bash
docker build -t nginx-static .
docker run -p 80:80 nginx-static
```

## Verification
- Visit `http://localhost:80` in your browser
- The HTML page with a click counter button should load
