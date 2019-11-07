KEYS = [:id, :title, :overview, :release_date, :inventory, :available_inventory]

class MoviesController < ApplicationController
  
  def index
    movies = Movie.all.as_json(only: [:id, :title, :overview, :release_date, :inventory, :available_inventory])
    render json: movies, status: :ok
  end
  
  # def show
  #   movie = Movie.find_by(id: params[:id])
  
  if movie
    render json: movie.as_json(only: KEYS)
    return
  else
    render json: { ok: false, errors: 'Not found'}, status: :not_found
    return
  end
end

def create
  movie = Movie.new(movie_params)
  if 
    render json: movie.as_json(only: [:id]), status: :created
    return
  else
    #do something
  end
end

private 

def movie_params
  params.require(:movie).permit(:title, :overview, :release_date, :inventory, :available_inventory)
end
end