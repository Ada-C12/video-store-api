KEYS = [:id, :title, :overview, :release_date]

class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: KEYS), status: :ok
    return
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: [:id, :title, :release_date, :overview, :inventory, :available_inventory]), status: :ok
      return
    else
      render json: { "errors" => ["not found"] }, status: :not_found
      return
    end
  end

  def create
  end
end
