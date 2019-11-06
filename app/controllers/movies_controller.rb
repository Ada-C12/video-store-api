KEYS = [:id, :title, :release_date]

class MoviesController < ApplicationController
  
  def index
    movies = Movie.all
    render json: movies.as_json(only: KEYS), status: :ok
  end
  
end
