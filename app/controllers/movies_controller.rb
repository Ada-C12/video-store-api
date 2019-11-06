class MoviesController < ApplicationController
  
  def index
    movies = Movie.all.as_json(only: [:id, :title, :release_date])
    render json: movies, status: :ok
  end
  
  def show
    movie = Movie.find_by(id: params[:id])
    
    if movie
      render json: movie.as_json(only: [:id, :title, :overview, :release_date, :inventory])
    else 
      render json: {"errors" => ["not found"]}, status: :not_found
    end
  end
end