class MoviesController < ApplicationController
  
  def index
    render json: { ready_for_lunch: "yassss" }, status: :ok
    
    # zomg = Movies.all.as_json(only: id:, :registered_at, :address, :city, :state, :postal_code, :phone)
    # render json: movies, status: ok
  end
  
end
