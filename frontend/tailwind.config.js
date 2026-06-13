/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,jsx}'],
  theme: {
    extend: {
      colors: {
        bg:      '#191919',
        card:    '#222222',
        border:  '#2e2e2e',
        accent:  '#d13a97',
        accent2: '#8b2fc9',
        teal:    '#00c896',
        warn:    '#ffb020',
        danger:  '#ff4d4f',
        muted:   '#aaaaaa',
        muted2:  '#666666',
      },
      fontFamily: {
        sans:  ['DM Sans', 'sans-serif'],
        serif: ['Playfair Display', 'serif'],
        mono:  ['DM Mono', 'monospace'],
      },
      backgroundImage: {
        'brand-grad': 'linear-gradient(135deg, #d13a97, #8b2fc9)',
      },
    },
  },
  plugins: [],
}
