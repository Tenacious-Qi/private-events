// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener("turbo:load", () => {
  const burgerIcon = document.querySelector('#burger');
  const navbarMenu = document.querySelector('#nav-links');
  burgerIcon.addEventListener('click', () => {
    navbarMenu.classList.toggle('is-active')
  })
});