class RentalsController < ApplicationController
  def checkout
    movie = Movie.find_by(id: params[movie_id])
    if movie.nil?
      render json: {"errors" => ["not found"]}, status: :not_found
      return
    end
    customer = Customer.find_by(id: params[customer_id])
    if customer.nil?
      render json: {"errors" => ["not found"]}, status: :not_found
      return
    end
    
    if movie.inventory < 1
      render json: {"errors" => ["not in stock"]}, status: :bad_request
      return
    end
    rental = Rental.new(rental_params)
    rental.checkout_date = Date.now
    rental.due_date = checkout_date + 7
    
    if rental.save
      render json: rental.as_json, status: :ok
      movie.inventory -= 1
      customer.movies_checked_out_count += 1
    else
      render json: { errors: rental.errors.messages }, status: :bad_request
    end
  end
  def checkin
    # add back to inventory
  end
  
  private
  
  def rental_params
    params.require(:rental).permit(:checkout_date, :checkin_date, :customer_id, :movie_id, :due_date)
  end
  