Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #nest new et create in ship
    #ship resources
    #resources :bookings, only: %i[new create]
  resources :bookings, only: %i[index edit update destroy]
end
