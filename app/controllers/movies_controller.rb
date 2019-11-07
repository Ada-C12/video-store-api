class MoviesController < ApplicationController
  MOVIE_INDEX_FIELDS = ["id", "title", "release_date"]
  MOVIE_SHOW_FIELDS = ["title", "overview", "release_date", "inventory", "available_inventory"]

  def index
    movies = Movie.all.as_json(only: MOVIE_INDEX_FIELDS)
    render json: movies, status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      found_movie = movie.as_json(only: MOVIE_SHOW_FIELDS)
      render json: found_movie, status: :ok
      return
    else
      render json: {"errors" => "not_found"}, status: :not_found
      return
    end
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: movie.as_json(only: [:id]), status: :ok
      return
    else 
      render json: {
        ok: false,
        errors: movie.errors.messages
        }, status: :bad_request
      return
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end


end
