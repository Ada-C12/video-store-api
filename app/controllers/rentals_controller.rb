class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)

    rental.setup_dates

    if rental.movie.check_inventory
      if rental.save
        rental.movie.decrease_inventory
        rental.customer.increase_movies_checkout
        render json: rental.as_json(only: [:customer_id, :movie_id]), status: :ok
        return
      else
        render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
        return
      end
    else
      render json: { ok: false, errors: "Stock unavailable!" }, status: :bad_request
    end
  end

  def checkin
    rental = Rental.find_by(rental_params)
    if rental
      rental.movie.increase_inventory
      rental.customer.decrease_movies_checkout
      render json: rental.as_json(only: [:customer_id, :movie_id]), status: :ok
      return
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
      return
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
