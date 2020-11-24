Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: %i[index edit update destroy]
  resources :ships do
    resources :bookings, only: %i[new create]
  end
end
