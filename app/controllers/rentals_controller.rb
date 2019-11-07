class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)

    if rental.checkout
      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: {
        ok: false,
        errors: rental.errors.messages
      }, status: :bad_request
      return
    end
  end

  def checkin 
  end

  private 
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
