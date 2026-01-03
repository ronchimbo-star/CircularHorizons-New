// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import react from '@astrojs/react';
import netlify from '@astrojs/netlify';

// Netlify-specific configuration
export default defineConfig({
  integrations: [tailwind(), react()],
  output: 'server',
  adapter: netlify(),
});
