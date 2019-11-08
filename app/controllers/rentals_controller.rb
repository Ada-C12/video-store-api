class RentalsController < ApplicationController
  require 'pry'
  def checkout 
    movie = Movie.find_by(id: rental_params[:movie_id])
    customer = Customer.find_by(id: rental_params[:customer_id])
    
    if movie.available_inventory != 0 
      new_rental = Rental.new(rental_params)
      new_rental.check_out = Time.now
      new_rental.due_date = new_rental.check_out + (7*24*60*60)
      
      new_rental.movie.available_inventory -= 1
    else 
      render json: {ok: false, errors: "available inventory is 0"}, status: :bad_request
      return
    end 
    
    if new_rental.save && new_rental.movie.save
      render json: new_rental.as_json(only: [:customer_id, :movie_id]), status: :created 
      return
    else 
      render json: {ok: false, errors: new_rental.errors.messages}, status: :bad_request
      return
    end 
  end
  
  def checkin 
    found_rental = Rental.find_by(id: params[:id])
    if found_rental.nil?
      render json: {ok: false, errors: "Not found"}, status: :not_found
      return
    end

    found_rental.check_in = Time.now
    found_rental.movie.available_inventory += 1
    
    if found_rental.save && found_rental.movie.save
      render json: found_rental.as_json(only: [:check_in]), status: :ok 
      return
    else 
      render json: {ok: false, errors: found_rental.errors.messages}, status: :bad_request
      return
    end 
    
  end 
  
  private
  def rental_params
    params.permit(:customer_id, :movie_id, :checkout, :check_in, :check_out, :due_date)
  end
end
