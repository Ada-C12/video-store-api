Rails.application.routes.draw do
  
  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]

  post "/rentals/check-out", to: "movies#check_out"
  post "/rentals/check-in", to: "movies#check_in"
  
  # get "/auth/:provider/callback", to: "users#create", as: "auth_callback"

end
