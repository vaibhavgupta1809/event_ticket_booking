Rails.application.routes.draw do
  resources :bookings, only: [:new, :create]
  resources :events
  devise_for :users

  get 'my_events_and_bookings', to: 'events#user_event_and_bookings'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    root 'events#index'
  end
end
