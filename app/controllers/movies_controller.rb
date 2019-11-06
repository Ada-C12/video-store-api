class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end
  
  def show
    movie = Movie.find_by(id: params[:id])
    render json: movie.as_json(only: [:title, :overview, :release_date, :inventory])
  end

  def create
    new_movie = Movie.new(movie_params)
    if new_movie.save
      render json: { id: new_movie.id }, status: :created
    else
      render json: { ok: false, errors: new_movie.errors }
    end 
  end
  
  private
  
  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
  
end
