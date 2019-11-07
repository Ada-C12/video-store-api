class RentalsController < ApplicationController
  def checkout
    movie = Movie.find_by(id: rental_params[:movie_id])
    if movie && movie.available_inventory > 0
      rental = Rental.new(rental_params)
      # TO DO: rental.due_date = created_at + 1 week  
      rental.customer.movies_checked_out_count += 1
      rental.movie.available_inventory -= 1

      if rental.save && rental.customer.save && rental.movie.save
        render json: rental.as_json(only: [:id]), status: :ok
        return
      else
        render json: {
          ok: false,
          errors: movie.errors.messages
        }, status: :bad_request
        return
      end
    else
      render json: {
        ok: false,
        errors: "inventory unavailable"
      }, status: :bad_request
    end
  end 

  def checkin
    
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end

end
