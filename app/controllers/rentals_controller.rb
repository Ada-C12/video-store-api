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
    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id])
    
    if rental
      rental.checkin
      render status: :ok
      return
    else
      render json: { errors: { rental: "not found" } }, status: :bad_request
    end
  end

  private 
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
