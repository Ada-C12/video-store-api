class MoviesController < ApplicationController
  MOVIE_INDEX_FIELDS = ["id", "title", "release_date"]
  MOVIE_SHOW_FIELDS = ["title", "overview", "release_date", "inventory", "available_inventory"]

  def index
    movies = Movie.all.as_json(only: MOVIE_INDEX_FIELDS)
    render json: movies, status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id]).as_json(only: MOVIE_SHOW_FIELDS)
    if movie
      render json: movie, status: :ok
      return
    else
      render json: {"errors" => ["not found"]}, status: :not_found
    end
  end
end
