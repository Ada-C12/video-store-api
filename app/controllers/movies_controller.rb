class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :release_date, :title]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: movie.as_json(only: [:id, :release_date, :title]), status: :ok
    else
      render json: {"errors" => {"id" => ["Movie with id #{params[:id]} not found."]}}
    end
  end
end
