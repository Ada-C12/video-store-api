MOVIE_KEYS = ["id", "title", "release_date"]
MOVIE_KEYS2 = ["id", "title", "overview", "release_date", "inventory", "available_inventory"]

class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: MOVIE_KEYS), status: :ok
  end

  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)
    if movie
      render json: movie.as_json(only: MOVIE_KEYS2)
      return
    else
      render json: {"errors"=>["not found"]}, status: :not_found
      return
    end
  end

  def create
    new_movie = Movie.new(movie_params)
    if new_movie.save
      # if new_movie.release_date.class == String
      #   new_movie.release_date = Date.parse(new_movie.release_date)
      # end
      render json: new_movie.as_json(only: [:id]), status: :ok
    else
      render json: { errors: new_movie.errors.messages }, status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
