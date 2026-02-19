import { createServer } from 'http';
import { handler } from './dist/server/entry.mjs';

const PORT = process.env.PORT || 4321;
const HOST = process.env.HOST || '0.0.0.0';

const server = createServer(handler);

server.listen(PORT, HOST, () => {
  console.log(`Server running at http://${HOST}:${PORT}`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM signal received: closing HTTP server');
  server.close(() => {
    console.log('HTTP server closed');
  });
});
