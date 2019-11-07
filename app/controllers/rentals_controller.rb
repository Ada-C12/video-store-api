class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    # p "KRISTINA"
    # p rental.movie
    if rental.movie.check_inventory == true
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
    else
      render json: {
        ok: false,
        errors: ["movie not available"],
        }, status: :bad_request
      return
    end
  end

  def checkin
    rental = Rental.find_by(id: params[:id]).as_json(only: [:id])
    if rental 
      rental.checkin_movie
      render json: rental, status: :ok
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
