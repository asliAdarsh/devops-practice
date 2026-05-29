// ===========================================
// Simple Express Server for Load Balancing Demo
// ===========================================
// Each instance returns its own hostname so you
// can see which server handled the request.

import express from 'express';
import os from 'os';

const app = express();
const PORT = 3000;

// Get the container hostname (set in docker-compose.yaml)
const hostname = os.hostname();

// Main route — shows which backend server handled the request
app.get('/', (req, res) => {
  res.json({
    message: 'Hello from the backend server!',
    server: hostname,
    port: PORT,
    timestamp: new Date().toISOString()
  });
});

// Health check endpoint for Nginx's passive health checks
app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

// Start the server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server ${hostname} running on port ${PORT}`);
});
