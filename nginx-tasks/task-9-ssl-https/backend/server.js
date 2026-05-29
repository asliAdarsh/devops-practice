const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.json({
    message: 'Hello via HTTPS!',
    protocol: req.protocol,
    secure: req.secure,
    headers: {
      'x-forwarded-proto': req.headers['x-forwarded-proto'],
      'x-real-ip': req.headers['x-real-ip']
    }
  });
});

app.listen(PORT, () => {
  console.log(`Backend server running on port ${PORT}`);
});
