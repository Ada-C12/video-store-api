class RentalsController < ApplicationController
  
  def checkout
    rental = Rental.new(movie_id: params[:movie_id], customer_id: params[:customer_id])
    
    rental.checkout_dates
    
    if rental.save
      render json: rental.as_json(only: [:id]), status: :ok
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
    end 
    
  end
  
  def checkin
    rentals = Rental.where(movie_id: params[:movie_id], customer_id: params[:customer_id])
    
    rental_to_check_in = nil
    
    rentals.each do |rental|
      if rental.due_date != nil
        rental_to_check_in = rental
      end
    end
    
    rental_to_check_in.check_in
    
    if rental_to_check_in.save
      render json: rental_to_check_in.as_json(only: [:id]), status: :ok
    else
      render json: { ok: false, errors: rental_to_check_in.errors.messages }, status: :bad_request
    end
  end
  
  private
  
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end

