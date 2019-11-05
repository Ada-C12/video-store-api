class RentalsController < ApplicationController
  
  def create
    rental = Rental.new(movie: Movie.first, customer: Customer.first)
    rental.checkout_date = Date.today
    rental.due_date = Date.today + 7


    if rental.movie.available_inventory > 0 && rental.save
      rental.check_out_rental
      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { "errors" => ["unable to create rental"]}, status: :bad_request
      return
    end
  end
  
end
