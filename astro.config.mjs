// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import react from '@astrojs/react';
import node from '@astrojs/node';
import netlify from '@astrojs/netlify';

// Use Netlify adapter for Netlify builds, Node adapter for local/bolt.new
const isNetlify = process.env.NETLIFY === 'true';

// https://astro.build/config
export default defineConfig({
  integrations: [tailwind(), react()],
  output: 'server',
  adapter: isNetlify ? netlify() : node({ mode: 'standalone' }),
});
