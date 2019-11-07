class RentalsController < ApplicationController
  def checkout
    movie = Movie.find_by(id: rental_params[:movie_id])
    if movie.nil?
      render json: {"errors" => ["not found"]}, status: :not_found
      return
    end

    customer = Customer.find_by(id: rental_params[:customer_id])
    if customer.nil?
      render json: {"errors" => ["not found"]}, status: :not_found
      return
    end

    if movie.available_inventory.nil? || movie.available_inventory < 1
      render json: {"errors" => ["out of stock"]}, status: :bad_request
      return
    end

    rental = Rental.new(rental_params)
    rental.checkout_date = Date.today
    rental.due_date = rental.checkout_date + 7

    if rental.save
      movie.available_inventory -= 1
      customer.movies_checked_out_count += 1
      render json: rental.as_json, status: :ok
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
      rental
    end
  end
  def checkin
    # add back to inventory
  end

  private

  def rental_params
    params.permit(:checkout_date, :checkin_date, :customer_id, :movie_id, :due_date)
  end
end