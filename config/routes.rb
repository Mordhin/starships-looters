Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/support', to: 'pages#support', as: 'support'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bookings, only: %i[index edit update destroy] do
    member do
      patch :validate
      patch :decline
      patch :pay
      patch :close
      patch :cancel
    end
  end

  resources :ships do
    resources :bookings, only: %i[new create]
  end

  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end

  get 'my_ships', to: 'ships#profil', as: :my_ships
end
