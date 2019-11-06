class MoviesController < ApplicationController
  
  def index
    movies = Movie.all.as_json(only: [:id, :title, :overview, :release_date, :inventory])
    render json: movies, status: :ok
  end
  
  def show
    movie = Movie.find_by(id: params[:id])
    
    if movie
      render json: movie.as_json(only: :id, :title, :overview, :release_date, :inventory)
      return
    else
      render json: { ok: false, errors: 'Not found'}, status: :not_found
      return
    end
  end
  
end
