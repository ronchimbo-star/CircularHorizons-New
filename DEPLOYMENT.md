# Deployment Guide for Circular Horizons

## Version 0.0.6 - Critical Fix Applied

### What Was Fixed

**Problem:** The previous server wrapper was trying to manually wrap the Astro handler, which caused conflicts with Astro's built-in standalone mode.

**Solution:** The server now properly uses Astro's native standalone server startup, which automatically handles:
- HTTP request routing
- Static file serving
- Environment variable detection
- Port binding
- Graceful shutdown

### How the Server Works Now

1. **server.js** sets environment variables (PORT, HOST)
2. **server.js** imports `dist/server/entry.mjs`
3. **entry.mjs** automatically starts Astro's standalone server
4. The standalone server respects `process.env.PORT` and `process.env.HOST`

This is the **correct** way to deploy Astro with the Node adapter in standalone mode.

## Deployment Checklist for Bolt.host

### 1. Platform Settings

**CRITICAL:** The application MUST be deployed as a Node.js application, NOT a static site.

- **Runtime:** Node.js 18 or higher
- **Build Command:** `npm run build`
- **Start Command:** `npm start`
- **Install Command:** `npm ci` (or `npm install`)

### 2. Environment Variables

Set these in the platform dashboard:

```bash
VITE_SUPABASE_URL=https://hgpgwnwbzqrwsfoblcjm.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhncGd3bndienFyd3Nmb2JsY2ptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjczMDI2MDYsImV4cCI6MjA4Mjg3ODYwNn0.5Ch-7n1fPeqyz2eJN3SiGkPiq36cnOEKSb9bVqQ5mRo
```

**Note:** DO NOT set PORT or HOST manually. The platform provides these automatically.

### 3. Deployment Process

1. **Clear any build cache** - Important to avoid old build artifacts
2. **Verify Node.js runtime** is selected (not static hosting)
3. **Check environment variables** are set correctly
4. **Deploy from latest commit**
5. **Monitor build logs** for any errors

### 4. Verify Deployment Success

Check the deployment logs for these messages:

```
=================================
Circular Horizons Server Starting
=================================
Environment: production
Host: 0.0.0.0
Port: [PLATFORM_PROVIDED_PORT]
Node Version: v18.x.x
Platform: linux
Working Directory: /app
=================================
Build output verified ✓
Loading Astro server...

✓ Server started successfully
✓ Ready to accept connections on http://0.0.0.0:[PORT]
[@astrojs/node] Server listening on http://localhost:[PORT]
```

If you see these messages, the server started correctly!

### 5. Test the Deployment

Once deployed, test these URLs:

```bash
# Health check - should return JSON
https://your-app.bolt.host/health

# Homepage
https://your-app.bolt.host/

# Contact page
https://your-app.bolt.host/contact

# Admin login
https://your-app.bolt.host/admin/login

# News page
https://your-app.bolt.host/news
```

## Troubleshooting 404 Errors

If you still get 404 errors after deployment:

### Issue 1: Wrong Deployment Type

**Symptom:** All routes return 404
**Cause:** Platform is serving static files instead of running Node.js server
**Fix:** Change deployment type to "Node.js" or "Server-Side Rendering"

### Issue 2: Build Artifacts Missing

**Symptom:** Server fails to start with "Build output not found"
**Cause:** Build command didn't complete successfully
**Fix:** Check build logs, ensure `npm run build` completes without errors

### Issue 3: Port Binding Issues

**Symptom:** Server starts but can't be reached
**Cause:** Server listening on wrong port or host
**Fix:** Check deployment logs show correct PORT, ensure HOST is 0.0.0.0

### Issue 4: Environment Variables Not Set

**Symptom:** Pages load but features don't work
**Cause:** Supabase environment variables missing
**Fix:** Set VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY in platform dashboard

### Issue 5: Old Build Cached

**Symptom:** Changes not reflected in deployed version
**Cause:** Platform serving cached build
**Fix:** Clear build cache and redeploy

## Understanding the Server Logs

The server provides comprehensive logging to help debug issues:

### Startup Logs

```
=================================
Circular Horizons Server Starting
=================================
Environment: production          <- Should be "production"
Host: 0.0.0.0                   <- Should be 0.0.0.0 for containers
Port: 8080                      <- Platform-provided port (varies)
Node Version: v18.x.x           <- Should be 18 or higher
Platform: linux                 <- Platform OS
Working Directory: /app         <- Server working directory
=================================
Build output verified ✓         <- Dist folder exists
Loading Astro server...         <- Starting Astro

✓ Server started successfully   <- Astro started
✓ Ready to accept connections   <- Ready for traffic
[@astrojs/node] Server listening <- Astro confirmation
```

### Error Logs

If startup fails, you'll see:

```
✗ Failed to start server:
[Error details here]
```

Common errors:
- **EADDRINUSE:** Port already in use (usually platform issue)
- **ENOENT:** Build output not found (run npm run build)
- **MODULE_NOT_FOUND:** Dependency missing (run npm ci)

## Local Testing

Test locally before deploying:

```bash
# Install dependencies
npm ci

# Build the application
npm run build

# Start the server
npm start

# In another terminal, test endpoints
curl http://localhost:4321/health
curl http://localhost:4321/
```

Test with custom port (simulates platform behavior):

```bash
PORT=8080 npm start
```

## Build Output Structure

After `npm run build`, you should have:

```
dist/
├── client/              # Static assets
│   ├── _astro/         # JS, CSS bundles
│   └── favicon.svg
└── server/              # SSR server
    ├── entry.mjs       # Server entry point ← Important!
    ├── chunks/         # Server code
    ├── pages/          # Rendered pages
    └── manifest_*.mjs  # Route manifest
```

The `dist/server/entry.mjs` file is critical - this is what starts the server.

## Platform-Specific Notes

### Bolt.host

- Uses containerized Node.js runtime
- Automatically provides PORT environment variable
- Requires build before start (doesn't cache dist/)
- Supports graceful shutdown with SIGTERM

### Alternative Platforms

If deploying elsewhere:

**Render.com:**
- Same configuration works
- Set "Build Command" and "Start Command"
- Add environment variables in dashboard

**Railway.app:**
- Auto-detects Node.js
- Reads PORT from environment
- Set environment variables in project settings

**Fly.io:**
- May need fly.toml configuration
- Uses similar PORT/HOST setup
- Check Fly.io Node.js docs

## Getting Help

If deployment still fails:

1. **Check deployment logs** - Look for specific error messages
2. **Verify platform settings** - Ensure Node.js runtime selected
3. **Test locally** - Confirm build works on your machine
4. **Clear cache** - Platform caching can cause issues
5. **Contact platform support** - Provide logs showing server startup messages

## Summary

The application is properly configured for deployment on Node.js hosting platforms. The server automatically:
- Detects PORT from environment
- Binds to 0.0.0.0 for container compatibility
- Provides comprehensive startup logging
- Handles graceful shutdown
- Serves all routes correctly

If you see the startup success messages in the logs, the server is working correctly!
