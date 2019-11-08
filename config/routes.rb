Rails.application.routes.draw do
  resources :customers, only: [:index]
  
  resources :movies, only: [:index, :show, :create] do 
    post "/rentals/checkout", to: "rentals#checkout", as: "checkout"
  end 
end
