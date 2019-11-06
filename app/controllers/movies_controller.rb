MOVIE_KEYS = ["id", "title", "overview", "release_date", "inventory", "available_inventory"].sort

class MoviesController < ApplicationController
  def index
    movies = Movie.all.as_json(only: MOVIE_KEYS)
    render json: movies, status: :ok
  end
  
  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)
    
    if movie
      render json: movie.as_json(only: MOVIE_KEYS), status: :ok
      return
    else
      render json: {"errors"=>["not found"]}, status: :not_found
      return
    end
  end
  
  private
  
  def movie_params
    params.require(:movie).permit("title", "overview", "release_date", "inventory", "available_inventory")
  end
end

