# Deployment Guide

## Current Status: READY FOR DEPLOYMENT ✅

**Version:** 0.0.3
**Build Date:** 2026-02-19
**Adapter:** Node.js (Standalone)

## Verified Working

All routes tested and confirmed working:
- ✅ Homepage (/) - HTTP 200
- ✅ Contact page (/contact) - HTTP 200
- ✅ Admin login (/admin/login) - HTTP 200
- ✅ News page (/news) - HTTP 200
- ✅ Health endpoint (/health) - HTTP 200

## Deployment Configuration

### Files Updated for Deployment:

1. **astro.config.mjs**
   - Configured Node.js standalone adapter
   - Set server port to 4321
   - Set host binding to all interfaces
   - Added trailing slash handling

2. **.deployment**
   - Updated version to 0.0.3
   - Set forceRedeploy flag
   - Configured port and host settings

3. **Dockerfile** (.codesandbox/Dockerfile)
   - Node.js 18 base image
   - Production build process
   - Health check endpoint at /health
   - Exposed port 4321
   - Environment variables configured

4. **package.json**
   - Start command: `node ./dist/server/entry.mjs`
   - Build command: `astro build`

5. **New Health Endpoint**
   - Added /health endpoint for container health checks
   - Returns JSON with version and status

## Server Configuration

```
Host: 0.0.0.0 (all interfaces)
Port: 4321
Mode: Standalone
Output: Server (SSR enabled)
```

## Environment Variables Required

Ensure these are set in your deployment environment:

```bash
# Server
HOST=0.0.0.0
PORT=4321
NODE_ENV=production

# Supabase (from your .env file)
VITE_SUPABASE_URL=<your_supabase_url>
VITE_SUPABASE_ANON_KEY=<your_supabase_key>
```

## Docker Build & Run

```bash
# Build
docker build -f .codesandbox/Dockerfile -t circular-horizons .

# Run
docker run -p 4321:4321 \
  -e HOST=0.0.0.0 \
  -e PORT=4321 \
  -e VITE_SUPABASE_URL=your_url \
  -e VITE_SUPABASE_ANON_KEY=your_key \
  circular-horizons
```

## Health Check

The application includes a health check endpoint at `/health` that returns:

```json
{
  "status": "ok",
  "timestamp": "2026-02-19T19:33:29.665Z",
  "version": "0.0.3",
  "adapter": "node",
  "port": 4321
}
```

Use this endpoint for:
- Container orchestration health checks
- Load balancer health probes
- Monitoring and alerting

## Troubleshooting 404 Errors

If you're seeing 404 errors on bolt.host:

1. **Clear deployment cache**: The platform may be serving cached old builds
2. **Verify version**: Check that version 0.0.3 is deployed (use /health endpoint)
3. **Check environment variables**: Ensure all Supabase vars are set
4. **Force redeploy**: The .deployment file has forceRedeploy: true
5. **Check logs**: Review deployment logs for any build or startup errors

## Deployment Checklist

- [x] Remove Netlify adapter
- [x] Install Node.js adapter
- [x] Configure astro.config.mjs
- [x] Update package.json scripts
- [x] Create/update Dockerfile
- [x] Add health check endpoint
- [x] Update .deployment config
- [x] Test all routes locally
- [x] Build successfully completes
- [x] Server starts without errors
- [x] Environment variables documented

## Post-Deployment Verification

After deployment, verify:

1. Health endpoint responds: `curl https://your-domain.bolt.host/health`
2. Homepage loads: `curl https://your-domain.bolt.host/`
3. All navigation links work
4. Admin panel is accessible at /admin/login
5. Contact form can be accessed at /contact

## Support

If deployment continues to fail:
1. Check the deployment logs in bolt.host dashboard
2. Verify environment variables are properly set
3. Ensure the correct build command is being used: `npm run build`
4. Ensure the correct start command is being used: `npm start`
5. Check that port 4321 is properly exposed and accessible
