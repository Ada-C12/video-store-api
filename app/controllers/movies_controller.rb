class MoviesController < ApplicationController
  KEYS = [:id, :title, :overview, :release_date, :inventory, :available_inventory]

  def index
    movies = Movie.all.as_json(only: KEYS)
    render json: movies, status: :ok
  end
  
  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: KEYS), status: :ok
      return
    else
      render json: {
        errors: {
          id: ["No movie with the id of '#{params[:id]}' found"]}
        }, status: :not_found
      return
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: movie.as_json(only: KEYS), status: :created
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
    params.permit(:available_inventory, :title, :overview, :release_date, :inventory)
  end
end
