// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
// app/javascript/application.js
import Rails from "@rails/ujs"
Rails.start()

document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.alert .close').forEach(function(button) {
    button.addEventListener('click', function() {
      this.parentElement.style.display = 'none';
    });
  });
});