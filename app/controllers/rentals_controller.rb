class RentalsController < ApplicationController
  def checkout
    new_rental = Rental.new(rental_params)
    new_rental.checkout_date =  Date.today
    new_rental.due_date =  Date.today + 7.days
    if new_rental.save
      new_rental.decrease_available()
      render json: new_rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, errors: new_rental.errors.messages }, status: :bad_request
      return
    end
  end
  
  def checkin
    rental = Rental.find_by(rental_params)
    
    if rental
      rental.checkin_date = Date.today
    else
      render json: { ok: false, errors: "This rental does not exist" }, status: :bad_request
      return
    end
    
    if rental.save
      rental.increase_available()
      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
      return
    end
  end
  
  private
  
  def rental_params
    params.permit(:movie_id, :customer_id, :checkout_date)
  end
end
