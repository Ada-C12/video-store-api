class RentalsController < ApplicationController
  before_action :find_customer, only: [:check_out]
  before_action :find_movie, only: [:check_out]
  before_action :find_rental, only: [:check_in]
  
  def check_out
    rental = Rental.check_out(@customer, @movie)
    if rental != nil
      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, errors: 'No available inventory'}, status: :bad_request
      return
    end
  end
  
  def check_in
    rental = Rental.check_in(@rental)
    if rental
      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, errors: 'Could not return'}, status: :bad_request
      return
    end
  end

  private

  def find_customer
    @customer = Customer.find_by(id: params[:customer_id])
    
    if @customer.nil?
      render json: { ok: false, errors: 'Invalid customer or movie ID!'}, status: :bad_request
      return
    end
  end

  def find_movie
    @movie = Movie.find_by(id: params[:movie_id])

    if @movie.nil?
      render json: { ok: false, errors: 'Invalid customer or movie ID!'}, status: :bad_request
      return
    end
  end

  def find_rental
    @rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id])
    
    if @rental.nil?
      render json: { ok: false, errors: 'Invalid customer or movie ID!'}, status: :bad_request
      return
    end
  end
end
