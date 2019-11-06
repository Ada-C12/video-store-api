Rails.application.routes.draw do
  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]

  post "/rentals/check-out", to: "movies#checkout", as: "checkout_movie"
  post "/rentals/check-in", to: "movies#checkin", as: "checkin_movie"
end
