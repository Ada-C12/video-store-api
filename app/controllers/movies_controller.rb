class MoviesController < ApplicationController
  MOVIE_FIELDS = ["id", "title", "release_date"]
  
  def index
    movies = Movie.all.as_json(only: MOVIE_FIELDS)
    render json: movies, status: :ok
  end
end
