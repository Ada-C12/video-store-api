class RentalsController < ApplicationController

  def checkout
    movie = Rental.find_movie(rental_params) 
    customer = Rental.find_customer(rental_params)

    if movie && customer && movie.available_inventory > 0 
      rental = Rental.new(rental_params)
      customer = rental.customer
      movie = rental.movie

      #Increment the amount of movies the customers has checked out 
      customer.update_movies_checked_out("checkout")

      #Decrease the amount of movies there are available in the movie's available inventory
      movie.update_available_inventory("checkout")

      if rental.save && customer.save && movie.save 
        render json: rental.as_json(only: [:id]), status: :ok 
        return 
      else 
        bad_request(rental)
      end  
    else 
      render json: {
        ok: false,
        errors: "none available"
      }, status: :bad_request
    end 
  end 


  def checkin 
    movie = Rental.find_movie(rental_params) 
    customer = Rental.find_customer(rental_params)

    customer.update_movies_checked_out(checkin)
    movie.update_available_inventory(checkin) 
    
    if customer.save && movie.save 
      render json: rental.as_json(only: [:id]), status: :ok 
      return 
    else
      bad_request(rental)
    end 
  end 


  private 

  def rental_params
    params.permit(:movie_id, :customer_id)
  end 

end
