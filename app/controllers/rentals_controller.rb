class RentalsController < ApplicationController
  def create
    customer = Customer.find_by(id: params[:customer_id])
    if customer.nil?
      render json: {
        ok: false,
        errors: { customer_id: "Invalid customer id" }
      }, status: :bad_request
      return
    end

    movie = Movie.find_by(id: params[:movie_id])
    if movie.nil?
      render json: {
        ok: false,
        errors: { movie_id: "Invalid movie id" }
      }, status: :bad_request
      return
    end

    rental = Rental.new(rental_params)
    rental.checkout_date = Date.today
    rental.due_date = Date.today + 7
    rental.save
    render json: rental.as_json(only: [:id]), status: :ok
    return
  end

  def update
    customer = Customer.find_by(id: params[:customer_id])
    if customer.nil?
      render json: {
        ok: false,
        errors: { customer_id: "Invalid customer id" }
      }, status: :bad_request
      return
    end

    movie = Movie.find_by(id: params[:movie_id])
    if movie.nil?
      render json: {
        ok: false,
        errors: { movie_id: "Invalid movie id" }
      }, status: :bad_request
      return
    end

    rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])
    if rental.nil?
      render json: {
        ok: false,
        errors: { rental_id: "Invalid rental id" }
      }, status: :bad_request
      return
    else
      rental.returned = true
      rental.save
      render json: rental.as_json(only: [:id]), status: :ok
      return
    end
  end

  private
  def rental_params
    return params.permit(:customer_id, :movie_id)
  end
end
