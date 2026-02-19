// Production server wrapper with comprehensive logging
// This ensures proper environment variable handling for any hosting platform

const PORT = process.env.PORT || 4321;
const HOST = process.env.HOST || '0.0.0.0';
const NODE_ENV = process.env.NODE_ENV || 'production';

// Set environment variables before importing entry.mjs
process.env.PORT = String(PORT);
process.env.HOST = HOST;

console.log('=================================');
console.log('Circular Horizons Server Starting');
console.log('=================================');
console.log(`Environment: ${NODE_ENV}`);
console.log(`Host: ${HOST}`);
console.log(`Port: ${PORT}`);
console.log(`Node Version: ${process.version}`);
console.log(`Platform: ${process.platform}`);
console.log(`Working Directory: ${process.cwd()}`);
console.log('=================================');

// Verify dist folder exists
import { existsSync } from 'fs';
import { resolve } from 'path';

const distPath = resolve(process.cwd(), 'dist/server/entry.mjs');
if (!existsSync(distPath)) {
  console.error(`ERROR: Build output not found at ${distPath}`);
  console.error('Please run "npm run build" before starting the server');
  process.exit(1);
}

console.log('Build output verified ✓');
console.log('Loading Astro server...\n');

// Import entry.mjs - it will auto-start the server
import('./dist/server/entry.mjs')
  .then(() => {
    console.log('\n✓ Server started successfully');
    console.log(`✓ Ready to accept connections on http://${HOST}:${PORT}`);
  })
  .catch(err => {
    console.error('\n✗ Failed to start server:');
    console.error(err);
    process.exit(1);
  });

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('\nSIGTERM received, shutting down gracefully...');
  process.exit(0);
});

process.on('SIGINT', () => {
  console.log('\nSIGINT received, shutting down gracefully...');
  process.exit(0);
});
