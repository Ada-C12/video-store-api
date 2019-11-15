Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get "/zomg", to: "controller/zomg", as: "zomg_path"

  post "/rentals/check-in", to: "rentals#checkin", as: 'checkin'
  post "/rentals/check-out", to: "rentals#checkout", as: 'checkout'

  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]
  
end
