Rails.application.routes.draw do
  resources :customers, only: [:index, :show]
  resources :movies, only: [:index, :show]
end
