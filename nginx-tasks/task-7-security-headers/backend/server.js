// ===========================================
// Simple Express Server for Security Headers Demo
// ===========================================

import express from 'express';

const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.json({
    message: 'Security headers are being applied by Nginx!',
    note: 'Check the response headers in your browser DevTools.',
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Backend server running on port ${PORT}`);
});
