const express = require('express');
const app = express();
const port = 3000;

let hasCrashed = false; // Track if crash has occurred

app.get('/', (req, res) => {
  res.send('Hello, Chaos Engineer! System is alive.');
});

app.get('/health', (req, res) => {
  if (process.env.CRASH === 'true' && !hasCrashed) {
    hasCrashed = true; // Crash only once
    res.status(500).send('System is crashing!');
    setTimeout(() => process.exit(1), 1000); // Crash after responding
  } else {
    res.status(200).send('OK');
  }
});

app.listen(port, () => {
  console.log(`App running on port ${port}`);
});