class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(rental_params)
   
    if rental.save
      Rental.due_date(rental)
      Rental.status_checkout(rental)
      Customer.check_out_movie(rental_params[:customer_id])
      

      movie = Movie.find_by(id: rental_params[:movie_id])

      if (!movie.available_inventory)
        movie.available_inventory = movie.inventory
      end

      movie.available_inventory -= 1
      movie.available_inventory_will_change!
      movie.save
      render json: rental.as_json(only: [:customer_id, :movie_id])

      return
    else
      render json: { errors: ["Bad Request"] }, status: :bad_request
      return
    end
  end

  def check_in
    customer = Customer.find_by(id: rental_params[:customer_id]) 
    
    movie = Movie.find_by(id: rental_params[:movie_id])

    if rental = Rental.find_by(customer_id: customer.id, movie_id: movie.id)
      Customer.check_in_movie(customer)

      if (!movie.available_inventory)
        movie.available_inventory = movie.inventory
      end

      movie.available_inventory += 1
      movie.available_inventory_will_change!
      movie.save
      
      rental.status = "checked_in"
      rental.save

      render json: rental.as_json(only: [:customer_id, :movie_id])
      return
    else
      render json: { errors: ["Bad Request - Not checked out"] }, status: :bad_request
      return
    end
  end
  
  private 
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
