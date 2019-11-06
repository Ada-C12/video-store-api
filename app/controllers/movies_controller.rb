class MoviesController < ApplicationController

  def create
    new_movie = Movie.new(movie_params)
    if new_movie.save
      render json: new_movie.as_json(only: [:id]), status: :created
    else
      render json: {errors: ["errors"]}, status: :bad_request
    end
  end
end
