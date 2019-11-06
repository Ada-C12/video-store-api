class MoviesController < ApplicationController
  def index
    movies = Movie.all.as_json(only: [:id, :title, :release_date])
    render json: movies, status: :ok
  end
  
  def show
    movie = Movie.find_by(id: params[:id])
    
    if movie
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory])
      return
    else
      render json: { "errors": ["Not found"] }, status: :not_found
    end
  end
  
  def create
    movie = Movie.new(movie_params)
    
    if movie.save
      movie.available_inventory = movie.inventory 
      render json: movie.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, errors: movie.errors.messages }, status: :bad_request
      return
    end
  end
  
  private
  
  def movie_params
    params.permit(:title, :overview, :release_date, :inventory, :available_inventory)
  end
end
