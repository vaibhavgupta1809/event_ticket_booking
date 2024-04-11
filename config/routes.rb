Rails.application.routes.draw do
  devise_for :users
  resources :events, except: :show do 
    resources :bookings, only: [:new, :create]
  end

  get 'my_events_and_bookings', to: 'events#user_event_and_bookings'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    root 'events#index'
  end

  match "*path", to: "application#render_404", via: :all
end
