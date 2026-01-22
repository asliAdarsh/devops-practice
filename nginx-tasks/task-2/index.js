import express from 'express';

const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('Hey, I am running inside a Docker container!');
});

app.get('/admin', (req, res) => {
  res.send('Hey, I am admin!');
});

app.listen(PORT, '0.0.0.0',() => {
  console.log(`Server is running on http://localhost:${PORT}`);
});