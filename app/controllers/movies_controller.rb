class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :release_date, :title]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie.nil?
      render json: {
        ok: false,
        errors: {
          title: ["Movie not found"]
        }
      }, status: :not_found
      return
    end

    render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
  end

  def create
    new_movie = Movie.new(movie_params)

    if new_movie.save
      render json: new_movie.as_json(only: [:id]), status: :ok
    else
      render json: {
        ok: false,
        errors: new_movie.errors.messages
      }, status: :bad_request
    end
  end

  private 
  def movie_params
    return params.permit(:title, :overview, :release_date, :inventory, :available_inventory)
  end
end
