Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :customers, only: [:index]
  get "/customers/zomg", to: "customers#zomg", as: "customer_zomg"
  resources :movies
  resources :rentals

end
