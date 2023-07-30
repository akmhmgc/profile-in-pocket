// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', () => {
  const flash = document.getElementById('flash')
  if (flash) {
    setTimeout(() => {
      flash.classList.add('fadeout')
    }, 1000)
  }
})
