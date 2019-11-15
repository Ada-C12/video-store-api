class RentalsController < ApplicationController
  def checkout
    customer = Customer.find_by(id: params["rental"]["customer_id"])
    # binding.pry
    if customer.nil?
      render json: { ok: false, errors: ["Customer not found"] }, status: :bad_request
      return
    end
    movie = Movie.find_by(id: params["rental"]["movie_id"])
    if movie.nil?
      render json: { ok: false, errors: ["Movie not found"] }, status: :bad_request
      return
    end
    
    rental = Rental.new(checkout_date: Date.today, checkin_date: nil, due_date: Date.today + 7, customer_id: customer.id, movie_id: movie.id)
    
    if rental.save
      render json: rental.as_json, status: :ok
      return
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
      return
    end
  end
  
  def checkin
    customer = Customer.find_by(id: params["rental"]["customer_id"])
    if customer.nil?
      render json: { ok: false, errors: ["Customer not found"] }, status: :bad_request
      return
    end
    movie = Movie.find_by(id: params["rental"]["movie_id"])
    if movie.nil?
      render json: { ok: false, errors: ["Movie not found"] }, status: :bad_request
      return
    end
    
    rental = Rental.find_by(customer_id: customer.id, movie_id: movie.id)
    if rental.nil?
      render json: { ok: false, errors: ["Rental not found"] }, status: :bad_request
      return
    end
    
    if rental.update(checkin_date: Date.today)
      render json: rental.as_json, status: :ok
      return
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
      return
    end
  end
end
