class RentalsController < ApplicationController
  def check_out
    #check that movie is available
     rental = Rental.new(rental_params)
    # movie = Movie.find_by(id: params[:movie_id])
    # if movie.available_inventory > 0
      #set status
      if rental.save
        Rental.due_date(rental)
        # Rental.status_checkout(rental)

        Customer.check_out_movie(rental_params[:customer_id])
        Movie.check_out(rental_params[:movie_id])
        #decrement available_count
  
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
    if rental = Rental.find_by(customer_id: rental_params[:customer_id], movie_id: rental_params[:movie_id])
  
      customer = Customer.check_in_movie(customer)
      
      
   
      

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
