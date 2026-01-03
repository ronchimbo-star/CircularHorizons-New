# Deployment Configuration

## Status: Node Adapter Build Complete

### Changes Made
- Removed old Netlify adapter and all Netlify build files
- Configured Astro with Node adapter in standalone mode
- Created proper Docker configuration for deployment
- Added start script to run Node server: `npm start`
- Bumped version to 0.0.2 to force fresh deployment

### Build Structure
```
dist/
├── client/        # Static assets (JS, CSS, images)
└── server/        # Node.js SSR server
    └── entry.mjs  # Server entry point
```

### Configuration Files
- `astro.config.mjs`: Node adapter in standalone mode
- `package.json`: Start script runs `node ./dist/server/entry.mjs`
- `.codesandbox/Dockerfile`: Proper Node.js deployment configuration
- `.bolt/config.json`: Bolt.new deployment settings

### Server Details
- Port: 4321
- Host: 0.0.0.0
- Start Command: `npm start`
- Build Command: `npm run build`

### Verification
✅ No Netlify references in source code
✅ Fresh build with Node adapter
✅ Server entry point exists at dist/server/entry.mjs
✅ Dockerfile configured for Node deployment
✅ Start script properly configured

The bolt.host URL should now serve the Node application instead of the old Netlify 404 page.
