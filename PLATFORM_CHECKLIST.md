# Bolt.host Platform Deployment Checklist

## Required Platform Settings

### Runtime Configuration
- **Runtime:** Node.js
- **Node Version:** 18 or higher
- **Package Manager:** npm

### Build Settings
- **Build Command:** `npm run build`
- **Start Command:** `npm start`
- **Output Directory:** `dist` (but not used for static hosting)

### Important: Deployment Type
⚠️ **This MUST be deployed as a Node.js application, NOT as a static site**

The application uses:
- Server-Side Rendering (SSR)
- Dynamic routes
- API endpoints
- Database connections

### Environment Variables to Set

Required in the platform dashboard:

```
VITE_SUPABASE_URL=https://hgpgwnwbzqrwsfoblcjm.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhncGd3bndienFyd3Nmb2JsY2ptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjczMDI2MDYsImV4cCI6MjA4Mjg3ODYwNn0.5Ch-7n1fPeqyz2eJN3SiGkPiq36cnOEKSb9bVqQ5mRo
```

(The PORT variable will be automatically provided by the platform)

## Deployment Steps

1. **Clear any cached builds**
   - Look for "Clear cache" or "Reset" option in deployment settings
   - This ensures the old Netlify build doesn't persist

2. **Verify Runtime Settings**
   - Confirm Node.js is selected (NOT static hosting)
   - Confirm build and start commands are correct

3. **Set Environment Variables**
   - Add the Supabase URL and API key
   - Do NOT set PORT manually (platform provides this)

4. **Trigger New Deployment**
   - Use "Redeploy" or "Deploy from latest commit" option
   - Monitor the build logs for any errors

5. **Verify Deployment**
   - Once deployed, test these URLs:
     - `https://your-app.bolt.host/health` - Should return JSON with status
     - `https://your-app.bolt.host/` - Should show homepage
     - `https://your-app.bolt.host/contact` - Should show contact form

## Troubleshooting

### If you still get 404:

1. **Check deployment logs** for build errors
2. **Verify the runtime** is set to Node.js (not static)
3. **Check environment variables** are set correctly
4. **Try a fresh deployment** with cache cleared
5. **Check the start command** is `npm start` not something else

### Expected Startup Log

You should see in the deployment logs:
```
Server running at http://0.0.0.0:[PORT]
```

If you see this, the server is starting correctly.

### Health Check Endpoint

Test the health endpoint to verify the server is running:
```bash
curl https://your-app.bolt.host/health
```

Expected response:
```json
{
  "status": "ok",
  "timestamp": "2026-02-19T...",
  "version": "0.0.3",
  "adapter": "node",
  "port": 4321
}
```

## What Changed from Previous Deployments

**Version 0.0.5 fixes:**
- Added custom HTTP server wrapper (`server.js`)
- Removed hardcoded port configuration
- Simplified Astro configuration
- Added platform-specific configuration (`.bolt/config.json`)
- Improved environment variable handling

These changes ensure the application works correctly on container-based hosting platforms.

## Support

If deployment continues to fail after following these steps, the issue may be with:
1. Platform-specific routing configuration
2. Container networking settings
3. Platform-level caching that needs manual intervention

Check the platform documentation or contact platform support for Node.js SSR application deployment requirements.
