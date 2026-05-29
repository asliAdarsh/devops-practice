// ===========================================
// Simple Express Server for Access Control Demo
// ===========================================

import express from 'express';

const app = express();
const PORT = 3000;

// Shared root endpoint
app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to the public area!',
    note: 'You passed IP-based access control.',
    timestamp: new Date().toISOString()
  });
});

// Admin endpoint
app.get('/admin', (req, res) => {
  res.json({
    message: 'Welcome to the admin area!',
    note: 'You passed authentication.',
    timestamp: new Date().toISOString()
  });
});

// Public endpoint (no restrictions)
app.get('/public', (req, res) => {
  res.json({
    message: 'This is a public resource.',
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Backend server running on port ${PORT}`);
});
