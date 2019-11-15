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
      render json: { ok: false, "errors" => ["not found"] }, status: :not_found
      return
    end
  end

  def create
    movie = Movie.new(movie_params)
    movie.available_inventory = movie.inventory
    
    if movie.save
      render json: movie.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, "errors" => ["unable to create movie"] }, status: :bad_request
      return
    end
  end

  private

  def movie_params
    return params.permit(:title, :release_date, :overview, :inventory, :available_inventory)
  end
end
