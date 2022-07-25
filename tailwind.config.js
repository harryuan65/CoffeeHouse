const colors = require('tailwindcss/colors');

module.exports = {
  theme: {
    colors: {
      nav: '#00092C',
      accent: '#A67D6A',
      primary: '#E0A98F',
      'title-gray': '#5E6268',
      gray: colors.gray,
      white: colors.white,
      black: colors.black,
      flash: '#FAFAFA',
      success: '#068A18',
      alert: '#FF1C4C',
      visual: '#0E183F',
    },
    extend: {
      animation: {
        'fade-in-out': 'fade 4s forwards ease-in',
      },
      keyframes: {
        fade: {
          '0%': {
            opacity: 0,
          },
          '5%': {
            opacity: 1,
          },
          '90%': {
            opacity: 1,
          },
          '100%': {
            opacity: 0,
          },
        },
      },
    },
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
  ],
};
