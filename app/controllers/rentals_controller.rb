class RentalsController < ApplicationController
  def check_out
    #check that movie is available
     rental = Rental.new(rental_params)
    # movie = Movie.find_by(id: params[:movie_id])
    # if movie.available_inventory > 0
      #set status
      if rental.save
        Rental.due_date(rental)
        Rental.status_checkout(rental)
        #decrement available_count
        #increment customer movie_checked_out_coun
  
        render json: rental.as_json(only: [:customer_id, :movie_id]) 
        return
      else
        render json: { errors: ["Bad Request"] }, status: :bad_request
        return
      end
    # else
      # render json: {errors: ["No Inventory"]}, status: :bad_request
    # end
  end

  def check_in
    customer = Customer.find_by(id: rental_params[:customer_id])
    movie = Movie.find_by(id: rental_params[:movie_id])
    if rental = Rental.find_by(customer_id: customer.id, movie_id: movie.id)
  
      # rental.update(inventory: rental.inventory + 1)
      movie.update(inventory: movie.inventory + 1)
      
      #rental.save
      movie.save

      render json: rental.as_json(only: [:customer_id,:movie_id]) 
      return
    else
      render json: { errors: ["Bad Request - Not checked out"] }, status: :bad_request
      return
    end

    #increment available count
  end

  private 
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
