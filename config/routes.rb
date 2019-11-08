Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :movies, only: [:index, :show, :create]
  
  get "/rentals/overdue", to: "rentals#overdue", as: "overdue"
  post "/rentals/check-out", to: "rentals#create", as: "checkout"
  patch "/rentals/check-in", to: "rentals#update", as: "checkin"
  get "/customers", to: "customers#index", as: "customers"
end
