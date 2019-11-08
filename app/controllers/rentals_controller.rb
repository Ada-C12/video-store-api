class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.checkout_date = Time.now
    rental.due_date = Time.now + 7

    if rental.save
      rental.checkout_movie
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
    rental = Rental.find_by(id: params[:id])
    if rental 
      rental.checkin_movie
      found_rental = rental.as_json(only: [:id])
      render json: found_rental, status: :ok
      return
    else
      render json: {"errors" => ["not found"]}, status: :not_found
    end
  end
  
  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id)
  end

end
