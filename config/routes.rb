Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies
  resources :customers
  resources :rentals
  
  get '/zomg', to: 'homepage#index', as: 'homepage'
end
