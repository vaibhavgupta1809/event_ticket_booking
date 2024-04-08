# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js", preload: true
pin "popper", to: "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.2/dist/umd/popper.min.js", preload: true
# config/importmap.rb
pin "@rails/ujs", to: "rails_ujs.js"
