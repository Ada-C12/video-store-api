RENTAL_KEYS = ["id", "checkout_date", "due_date", "movie_id", "customer_id"]

class RentalsController < ApplicationController
  def index
    rentals = Rental.all.as_json(only: RENTAL_KEYS)
    render json: rentals, status: :ok
  end
  
  def show
    rental_id = params[:id]
    rental = Rental.find_by(id: rental_id) #This may be casing us some problems
    
    if rental
      render json: rental.as_json(only: RENTAL_KEYS), status: :ok
      return
    else
      render json: {"errors"=>["not found"]}, status: :not_found
      return
    end
  end
  
  def create
    rental = Rental.new(rental_params)
    
    if rental.save
      render json: rental.as_json(only: [:id]), status: :created
      return
    else
      render json: {"errors"=>["not found"]}, status: :not_found
      return
    end
  end
  
  def checkout(movie_id, customer_id)
    if movie_checkout(movie_id) && customer_checkout(customer_id)
      Rental.create(movie_id: movie_id, customer_id: customer_id, checkout_date: Time.now, due_date: (Time.now + 604800))
    else
      render json: {"errors"=>["Unable to Checkout"]}, status: :bad_request
    end
  end
    
  private
    
  def rental_params
    return params.permit("checkout_date", "due_date", "movie_id", "customer_id")
  end
end
  