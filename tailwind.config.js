module.exports = {
  theme: {
    colors: {
      nav: '#00092C',
      accent: '#A67D6A',
      'title-gray': '#5E6268',
      border: '#dadada',
      white: '#FFF',
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
