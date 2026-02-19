/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        primary: '#ea6214', // BRICSwise orange
        secondary: '#e9af0d', // BRICSwise gold
        accent: '#94c021', // BRICSwise green
        'accent-cyan': '#00ffff', // BRICSwise cyan
        'accent-pink': '#c10966', // BRICSwise magenta
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
