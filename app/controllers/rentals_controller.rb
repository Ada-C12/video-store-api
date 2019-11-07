class RentalsController < ApplicationController
  def checkout

    rental = Rental.new(customer_id: params[:customer_id], movie_id: params[:movie_id])

    if rental.save
      
      rental.checkout

      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: {
        ok: false,
        errors: rental.errors.messages
      }, status: :bad_request
      return
    end
  end

      
    # new_rental Rental.new(params params)
    # new_rental.checkout

    # if rental.checkout 
    # else 
    #   #not save 
    # end


  def checkin 
  end
end
