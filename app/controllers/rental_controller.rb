KEYS = [:id, :checkout_date, :due_date, :rental_id, :customer_id]

class RentalController < ApplicationController
  def index
    rentals = Rental.all.as_json(only: KEYS)
    render json: rentals, status: :ok
  end
  
  def show
    rental_id = params[:id]
    rental = Rental.find_by(id: rental_id)
    
    if rental
      render json: rental.as_json(only: KEYS), status: :ok
      return
    else
      render json: {"errors"=>["not found"]}, status: :not_found
      return
    end
  end
  
  private
  
  def rental_params
    params.require(:rental).permit(:checkout_date, :due_date, :rental_id, :customer_id)
  end
end
