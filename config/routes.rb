Rails.application.routes.draw do
  resources :customers, only: [:index]
  
  resources :movies, only: [:index, :show, :create] 

  post "/rentals/checkout", to: "rentals#checkout", as: "checkout"
end
