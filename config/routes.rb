Rails.application.routes.draw do
  resources :bookings
  resources :events
  devise_for :users

  get 'my_events_and_bookings', to: 'events#user_event_and_bookings'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    authenticated :user do
      root 'events#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
