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
    end
  end
  
  private
  
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
