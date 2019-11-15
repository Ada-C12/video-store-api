class RentalsController < ApplicationController
  before_action :find_customer, only: [:create, :update]
  before_action :find_movie, only: [:create, :update]

  def create
    rental = Rental.new(rental_params)
    rental.save
    @customer.movies_checked_out_count += 1
    @customer.save
    render json: rental.as_json(only: [:id]), status: :ok
    return
  end

  def update
    rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])
    if rental.nil?
      render json: {
        ok: false,
        errors: { rental_id: "Invalid rental id" }
      }, status: :bad_request
      return
    else
      if rental.returned == false  
        rental.returned = true
        rental.save
        @customer.movies_checked_out_count -= 1
        @customer.save
        render json: rental.as_json(only: [:id]), status: :ok
        return
      end
    end
  end

  private
  def rental_params
    return params.permit(:customer_id, :movie_id)
  end

  def find_movie
    @movie = Movie.find_by(id: params[:movie_id])
    if @movie.nil?
      render json: {
        ok: false,
        errors: { movie_id: "Invalid movie id" }
      }, status: :bad_request
      return
    end
  end

  def find_customer
    @customer = Customer.find_by(id: params[:customer_id])
    if @customer.nil?
      render json: {
        ok: false,
        errors: { customer_id: "Invalid customer id" }
      }, status: :bad_request
      return
    end
  end
end
