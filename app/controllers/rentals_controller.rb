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
    rental = Rental.update(customer_id, movie_id, status: "checked in")
    #increment available count
  end

  private 
  def rental_params
    params.permit(:customer_id, :movie_id)
  end
end
