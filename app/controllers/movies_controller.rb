class MoviesController < ApplicationController
  
  MOVIE_FIELDS = ['id', 'title', 'release_date']

  def index
    movies = Movie.all
    render json: movies.as_json(only: MOVIE_FIELDS), status: :ok
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
      params.permit(:title, :release_date, :overview, :inventory9)
    end
end
