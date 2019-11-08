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
    rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])
    rental.change_due_date
    
    if rental.save
      render json: rental.as_json(only: [:id]), status: :ok
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
    end
  end
  
  private
  
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end

