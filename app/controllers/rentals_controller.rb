class RentalsController < ApplicationController
  def checkout 
    movie = Movie.find_by(id: rental_params[:movie_id])
    customer = Customer.find_by(id: rental_params[:customer_id])

    new_rental = Rental.new(rental_params)
    
    if new_rental.save
      new_rental.check_out = Time.now
      new_rental.due_date = new_rental.check_out + (7*24*60*60)
      
      new_rental.movie.available_inventory -= 1 
      
      render json: new_rental.as_json(only: [:customer_id, :movie_id]), status: :created 
      return
    else 
      render json: {ok: false, errors: new_rental.errors.messages}, status: :bad_request
      return
    end 

  end 

  private
  def rental_params
    params.permit(:customer_id, :movie_id, :checkout, :check_in, :check_out, :due_date)
  end
end
