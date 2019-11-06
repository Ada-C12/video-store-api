KEYS = [:id, :title, :release_date]

class MoviesController < ApplicationController
  
  def index
    movies = Movie.all
    render json: movies.as_json(only: KEYS), status: :ok
  end
  
  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)
    if movie
      render json: movie.as_json(only: KEYS)
      return
    else
      render json: {"errors"=>["not found"]}, status: :not_found
      return
    end
  end
  
  def create
    new_movie = Movie.new(movie_params)
    if new_movie.save
      render json: new_movie.as_json(only: [:id]), status: :created
    else
      render json: { errors: new_movie.errors.messages }, status: :bad_request
    end
    
  end
  
  
  private
  
  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
    
  end
  
  
end
