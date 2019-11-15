class MoviesController < ApplicationController
  def index
    movies = Movie.all
    
    render :json => movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end
  
  def show
    movie = Movie.find_by_id(params[:id])
    
    if movie.nil?
      render json: {"errors" => {"id" => ["no movie by ID: #{params[:id]}"]}}, status: :not_found
      return
    end
    
    render :json => movie.as_json(only: [:id, :title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
  end
  
  def create
    movie = Movie.new(movie_params)
    
    if movie.save
      render json: movie.as_json(only: [:id, :title, :overview, :release_date, :inventory]), status: :ok
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
      params.permit(:title, :overview, :release_date, :inventory, :available_inventory)
    end
  end
  