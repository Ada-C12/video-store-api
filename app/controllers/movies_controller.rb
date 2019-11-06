class MoviesController < ApplicationController
  INDEX_MOVIE_FIELDS = ["id", "title", "release_date"]
  SHOW_MOVIE_FIELDS = ["id", "title", "overview", "release_date", "inventory", "available_inventory"]
  
  def index
    movies = Movie.all.as_json(only: INDEX_MOVIE_FIELDS)
    render json: movies, status: :ok
  end
  
  def show
    movie = Movie.find_by(id: params[:id])
    
    if movie
      movie.adjust_available_inventory()
      render json: movie.as_json(only: SHOW_MOVIE_FIELDS), status: :found
      return
    else
      render json: {errors: {id: "ID not found"}}, status: :bad_request
      return
    end
  end
end
