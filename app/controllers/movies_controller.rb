class MoviesController < ApplicationController
  MOVIE_FIELDS = ['id', 'title', 'release_date']
  
  def index
    movies = Movie.all
    render json: movies.as_json(only: MOVIE_FIELDS), status: :ok
  end 
  
  def show
    movie = Movie.find_by(id: params[:id])
    if movie 
      render json: movie, status: :ok
      return 
    else
      render json: {ok: false, errors: ["Not found"]}, status: :not_found 
      return
    end
  end
end
  
  