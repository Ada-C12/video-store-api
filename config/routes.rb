Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/rentals/check-out', to: 'rentals#create', as: "checkout"
  post '/rentals/check-in', to: 'rentals#update', as: "checkin"

  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]
end
