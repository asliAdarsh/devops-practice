// ===========================================
// Simple Express Server for Rate Limiting Demo
// ===========================================
// Returns a response so you can see when requests
// get through vs. when they're rate limited.

import express from 'express';

const app = express();
const PORT = 3000;

// Track request count for visualization
let requestCount = 0;

// Main route
app.get('/', (req, res) => {
  requestCount++;
  console.log(`[REQUEST #${requestCount}] Received at ${new Date().toISOString()}`);
  res.json({
    message: 'Request received!',
    requestNumber: requestCount,
    timestamp: new Date().toISOString()
  });
});

// Health check (no logging needed)
app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

// Simulated API endpoint
app.get('/api/data', (req, res) => {
  res.json({ data: 'sensitive data', timestamp: new Date().toISOString() });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Backend server running on port ${PORT}`);
});
