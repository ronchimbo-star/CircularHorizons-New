/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        primary: 'hsl(142, 47%, 33%)',
        secondary: 'hsl(206, 56%, 25%)',
        accent: 'hsl(48, 66%, 59%)',
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
