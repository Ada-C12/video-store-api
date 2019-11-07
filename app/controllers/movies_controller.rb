class MoviesController < ApplicationController
  MOVIE_FIELDS = ['id', 'title', 'release_date']

  def index
    movies = Movie.all
    render json: movies.as_json(only: MOVIE_FIELDS), status: :ok
  end 
end
