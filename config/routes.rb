Rails.application.routes.draw do
  resources :customers, only: [:index]
  
  resources :movies, only: [:index, :show, :create] 
  
  post "/rentals/checkout", to: "rentals#checkout", as: "checkout"
  patch "/rentals/:id/checkin", to: "rentals#checkin", as: "checkin"
end
