class MoviesController < ApplicationController
  def index
    movies = Movie.all.as_json(only: [:id, :title, :release_date])
    render json: movies, status: :ok
    return
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      if !movie.available_inventory && movie.available_inventory != 0
        movie.available_inventory = movie.inventory
        movie.save
      end
      render json: movie.as_json(only: [:title, :overview, :release_date, :inventory, :available_inventory])
      return
    else
      render json: { errors: ["Bad Request"] }, status: :bad_request
      return
    end
  end

  def create
    new_movie = Movie.new(movie_params)
    new_movie.available_inventory = movie_params[:inventory]

    if new_movie.save
      render json: new_movie.as_json(only: [:id]), status: :ok
      return
    else
      render json: { errors: ["BAD Request"] }, status: :bad_request
      return
    end
  end
end

private

def movie_params
  params.permit(:title, :overview, :release_date, :inventory, :available_inventory)
end
