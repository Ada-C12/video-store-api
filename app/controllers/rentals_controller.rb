class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.checkout_date = Date.today
    rental.due_date = Date.today + 7
    
    if rental.save
      render json: rental.as_json(only: [:due_date]), status: :ok
      return
    else
      render json: {errors: rental.errors.messages}, status: :bad_request
      return
    end
  end
  
  def checkin
    movie = Movie.find_by(id: rental_params[:movie_id])
    customer = Customer.find_by(id: rental_params[:customer_id])
    
    if movie && customer
      render json: {}, status: :ok
      return
    elsif movie
      render json: {errors: {customer: "customer ID could not be found"}}, status: :bad_request
      return
    else
      render json: {errors: {movie: "movie ID could not be found"}}, status: :bad_request
      return
    end
  end
  
  private
  
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
