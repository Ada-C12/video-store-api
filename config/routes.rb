Rails.application.routes.draw do

  resources :customers, only: [:index]
  resources :movies
  resources :rentals
  post "/rentals/checkout", to: "rentals#checkout", as: "checkout"
  post "/rentals/checkin", to: "rentals#checkin", as: "checkin"

end
