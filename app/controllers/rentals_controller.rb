class RentalsController < ApplicationController
  def checkout 
    movie = Movie.find_by(id: params[:id])
    customer = Customer.find_by(id: params[:id])

    movie.rentals.create(customer_id: customer.id, movie_id: movie.id)
    movie.check_out = Time.now
    movie.due_date = movie.check_out + (7*24*60*60)

    movie.available_inventory -= 1 
  end 
end
