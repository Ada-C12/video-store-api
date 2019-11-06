class MoviesController < ApplicationController

  def index 
    @movies = Movie.all
    movies = Movie.all.as_json(only: [:id, :title, :overview, :release_date, :inventory])
    render json: movies, status: :ok 
  end 

  def show 
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie.as_json(only: [:id, :title, :overview, :release_date, :inventory])
      return
    else 
      not_found
    end 
  end 

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: movie.as_json(only: [:id]), status: :created
      return
    else 
      bad_request(movie)
    end 
  end 

  private 
  
  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end 
end
