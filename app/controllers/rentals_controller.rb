class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.checkout_date = Date.today
    rental.due_date = Date.today + 7
    
    movie = Movie.find_by(id: rental.movie_id)
    if movie 
      if movie.available_inventory <=0
        render json: {errors: {movie: "insufficient available inventory"}},status: :bad_request
        return
      else 
        movie.available_inventory -= 1
      end
      # if movie == nil is not needed as it is addressed as part of the next if block
    end
    
    if rental.save && movie.save
      render json: rental.as_json(only: [:due_date]), status: :ok
      return
    else
      render json: {errors: rental.errors.messages}, status: :bad_request
      return
    end
  end
  
  def checkin
    movie = Movie.find_by(id: rental_params[:movie_id])
    customer = Customer.find_by(id: rental_params[:customer_id])
    
    if movie && customer
      rental = Rental.where(movie_id: movie.id, customer_id: customer.id, checkin_date: nil).first
      
      movie.available_inventory += 1
      movie.save
      render json: rental.as_json(only: [:id]), status: :ok
      return
    elsif movie
      render json: {errors: {customer: "customer ID could not be found"}}, status: :bad_request
      return
    else
      render json: {errors: {movie: "movie ID could not be found"}}, status: :bad_request
      return
    end
  end
  
  private
  
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
