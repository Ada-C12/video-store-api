KEYS = [:id, :title, :overview, :release_date, :inventory, :available_inventory]

class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :release_date, :title]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id]).as_json(only: KEYS)

    if movie
      render json: movie, status: :ok
      return
    else
      render json: {"errors" => ["Movie #{params[:id]} not found"]}, status: :not_found
      return
    end
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: movie.as_json(only: [:id]), status: :created
      return
    else
      render json: {errors: movie.errors.messages}, status: :bad_request
      return
    end
  end

  private

  def movie_params
    params.require(:movie).permit(KEYS)
  end
end
