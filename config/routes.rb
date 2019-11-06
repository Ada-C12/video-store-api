Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies
  resources :customers
  resources :rentals
  # post "/rentals/check-out", to: "rentals#checkout", as: "checkout"
  # post "/rentals/check-in", to: "rentals#checkin", as: "checkin"
end
