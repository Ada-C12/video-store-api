class RentalsController < ApplicationController
  
  def check_out
    customer_id = params[:customer_id]
    movie_id = params[:movie_id]
    
    movie = Movie.find_by(id: movie_id)
    customer = Customer.find_by(id: customer_id)
    
    if movie.nil? || customer.nil?
      render json: { ok: false, errors: 'Invalid customer or movie ID!'}, status: :bad_request
      return
    end
    
    rental = Rental.check_out(customer, movie)
    if rental
      render json: rental.as_json(only: [:id]), status: :created
      return
    else
      render json: { ok: false, errors: 'No available inventory'}, status: :bad_request
      return
    end
  end
  
  def check_in
    customer_id = params[:customer_id]
    movie_id = params[:movie_id]
    
    rental = Rental.find_by(customer_id: customer_id, movie_id: movie_id)
    
    if rental.nil?
      render json: { ok: false, errors: 'Invalid customer or movie ID!'}, status: :bad_request
      return
    end
    
    rental = Rental.check_in(rental)
    if rental
      render json: rental.as_json(only: [:id]), status: :created
      return
    else
      render json: { ok: false, errors: 'Could not return'}, status: :bad_request
      return
    end
    
  end
  
end
