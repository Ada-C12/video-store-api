class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.checkout_date = Date.today
    rental.due_date = Date.today + 7
    
    movie = Movie.find_by(id: rental.movie_id)
    customer = Customer.find_by(id: rental.customer_id)
    
    if customer.nil? 
      render json: {errors: {customer: "customer ID could not be found"}}, status: :bad_request
      return
    end
    
    if movie 
      if movie.available_inventory <=0
        render json: {errors: {movie: "insufficient available inventory"}},status: :bad_request
        return
      else 
        movie.available_inventory -= 1
        movie.save 
        
        customer.movies_checked_out_count += 1
        customer.save
      end
    else
      render json: {errors: {movie: "movie ID could not be found"}}, status: :bad_request
      return
    end
    
    if rental.save
      render json: rental.as_json(only: [:due_date]), status: :ok
      return
    end
  end
  
  def checkin
    movie = Movie.find_by(id: rental_params[:movie_id])
    customer = Customer.find_by(id: rental_params[:customer_id])
    
    if movie && customer
      rental = Rental.where(movie_id: movie.id, customer_id: customer.id, checkin_date: nil).first
      if rental.nil?
        render json: {errors: {rental: "Rental is not for this location"}}, status: :bad_request
        return
      end
      
      rental.checkin_date = Date.today
      rental.save
      
      movie.available_inventory += 1
      movie.save
      
      customer.movies_checked_out_count -= 1
      customer.save
      
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
