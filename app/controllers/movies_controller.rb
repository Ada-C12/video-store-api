class MoviesController < ApplicationController
  def index
    movies = Movie.all 
    render json: movies, status: :ok
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save 
      render json: movie.as_json(only [:id]), status: :created
    else 
      # do something
    end

  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
