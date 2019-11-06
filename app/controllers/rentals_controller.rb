class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.checkout_date = Time.now
    rental.due_date = Time.now + 7

    if rental.save
      render json: rental.as_json(only: [:id]), status: :created
      return
    else
      render json: {
        ok: false,
        errors: rental.errors.messages
        }, status: :bad_request
      return
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end
end
