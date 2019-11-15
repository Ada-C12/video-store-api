class MoviesController < ApplicationController
  INDEX_MOVIE_FIELDS = ["id", "title", "release_date"]
  SHOW_MOVIE_FIELDS = ["id", "title", "overview", "release_date", "inventory", "available_inventory"]
  
  def index
    movies = Movie.all.as_json(only: INDEX_MOVIE_FIELDS)
    render json: movies, status: :ok
  end
  
  def show
    movie = Movie.find_by(id: params[:id])
    
    if movie
      render json: movie.as_json(only: SHOW_MOVIE_FIELDS), status: :ok
      return
    else
      render json: {errors: {id: "ID not found"}}, status: :bad_request
      return
    end
  end
  
  def create
    movie = Movie.new(movie_params)
    
    if movie.save
      # status should be :created, but Postman wants :ok
      render json: movie.as_json(only: [:id]), status: :ok
      return
    else
      render json: {errors: movie.errors.messages}, status: :not_acceptable
      return
    end
  end
  
  private
  
  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
