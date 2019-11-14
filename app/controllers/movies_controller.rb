KEYS = [:title, :overview, :release_date, :inventory, :available_inventory]

class MoviesController < ApplicationController
  def index
    movies = Movie.all.as_json(only: [:id, :title, :release_date])
    render json: movies, status: :ok
  end
  
  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)
    
    if movie
      render json: movie.as_json(only: KEYS), status: :ok
    else 
      render json: { ok: false, errors: "Not Found"}, status: :not_found
      return
    end
  end
  
  def create
    movie = Movie.new(title: params[:title], overview: params[:overview], release_date:params[:release_date], inventory:params[:inventory])
    
    if movie.save 
      render json: movie.as_json(only: [:id, :title, :overview, :release_date, :inventory]), status: :ok
      return 
    else 
      render json: { ok: false, "errors" => ["Not Found"]}, status: :not_found
      return
    end
  end
  
  private
  
  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end
end
