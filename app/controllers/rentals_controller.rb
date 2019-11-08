class RentalsController < ApplicationController
  
  def create
    if params[:movie_id].nil? || params[:customer_id].nil?
      render json: { ok: false, "errors" => ["unable to create rental"]}, status: :bad_request
      return
    end
    
    rental = Rental.new(movie_id: params[:movie_id], customer_id: params[:customer_id])
    rental.checkout_date = Date.today
    rental.due_date = Date.today + 7 
    
    if rental.movie.available_inventory > 0 && rental.save
      rental.check_out_rental
      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, "errors" => ["unable to create rental"]}, status: :bad_request
      return
    end
  end
  
  def update
    rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])
    if rental
      rental.check_in_rental
      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, "errors" => ["rental not found"]}, status: :not_found
      return
    end
  end
  
  def overdue
    render json: Rental.overdue.as_json(only: [:id]), status: :ok
    return
  end
  
end
