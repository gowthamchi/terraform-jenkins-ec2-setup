const http = require('http');
const PORT = 3000;

const server = http.createServer((req, res) => {
  res.end('Hello from Node.js CI/CD via Jenkins!');
});

server.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
