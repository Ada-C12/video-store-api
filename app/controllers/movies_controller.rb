class MoviesController < ApplicationController
  
  MOVIE_FIELDS = ['id','inventory','overview','release_date','title']
  
  def index
    movies = Movie.all
    render json: movies.as_json(only: MOVIE_FIELDS), status: :ok
  end 
  
  def show
    movie = Movie.find_by(id: params[:id])
    if movie 
      render json: movie.as_json(only: MOVIE_FIELDS), status: :ok
      return 
    else
      render json: {ok: false, errors: ["Not found"]}, status: :not_found 
      return
    end
  end
  
  def create
    new_movie = Movie.new(movie_params)
    
    if new_movie.save
      render json: new_movie.as_json(only: [:id]), status: :created 
      return
    else 
      render json: {ok: false, errors: new_movie.errors.messages}, status: :bad_request
      return
    end 
  end 
  
  private
  
  def movie_params
    params.permit(:title, :release_date, :overview, :inventory)
  end
end

