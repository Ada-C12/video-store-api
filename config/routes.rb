Rails.application.routes.draw do
  resources :customers, only: [:index, :show]
  resources :movies, only: [:index, :show, :create]
  post '/rentals/checkout', to: 'rentals#checkout', as: 'rental_checkout'
  post '/rentals/:id/checkin', to: 'rentals#checkin', as: 'rental_checkin'
end
