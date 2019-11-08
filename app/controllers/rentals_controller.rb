RENTAL_KEYS = ["id", "checkout_date", "due_date", "movie_id", "customer_id"]

class RentalsController < ApplicationController
  before_action :find_movie, only: [:checkout, :checkin]
  before_action :find_customer, only: [:checkout, :checkin]
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
  
  def checkout
    @movie = Movie.find_by(id: params[:movie_id])
    @customer = Customer.find_by(id: params[:customer_id])


    if @movie.available_inventory >= 1
      @movie.available_inventory -= 1
      @movie.save!

      @customer.movies_checked_out_count += 1
      @customer.save!
      
      rental = Rental.new(movie_id: @movie.id, customer_id: @customer.id)
      rental.save!

      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: {"errors"=>["Unable to Checkout"]}, status: :bad_request
      return
    end
  end
  
  def checkin
    @movie = Movie.find_by(id: rental_params[:movie_id])
    @customer = Customer.find_by(id: rental_params[:customer_id])
    @rental = Rental.find_by(id: rental_params[:id])

    if @customer != nil && @movie != nil
      @movie.available_inventory += 1
      @movie.save!

      @customer.movies_checked_out_count -= 1
      @customer.save!

      render json: @rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: {"errors"=>["Unable to Checkin Rental"]}, status: :bad_request
      return
    end
  end
  
  private
  
  def rental_params
    return params.permit("movie_id", "customer_id")
  end
  
  def find_movie
    @movie = Movie.find_by(id: params[:movie])
  end
  
  def find_customer
    @customer = Customer.find_by(id: params[:customer])
  end
  
end
