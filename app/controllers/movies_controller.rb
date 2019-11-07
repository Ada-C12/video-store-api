MOVIE_KEYS = ["id", "title", "overview", "release_date", "inventory", "available_inventory"].sort

class MoviesController < ApplicationController
  before_action :find_movie, only: [:show]
  
  def index
    movies = Movie.all.as_json(only: MOVIE_KEYS)
    render json: movies, status: :ok
  end
  
  def show
    if @movie.nil?
      render json: {"errors"=>["not found"]}, status: :not_found
      return
    else
      render json: @movie.as_json(only: MOVIE_KEYS), status: :ok
      return
    end
  end
  
  def create
    movie = Movie.new(movie_params)
    
    if movie.save
      render json: movie.as_json(only: [:id]), status: :ok
      return
    else
      render json: {ok: false, errors: movie.errors}, status: :bad_request
      return
    end
  end
  
  private
  
  def movie_params
    return params.permit("title", "overview", "release_date", "inventory", "available_inventory")
  end
  
  def find_movie
    @movie = Movie.find_by(id: params[:id])
  end
end

