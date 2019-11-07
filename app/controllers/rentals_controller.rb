class RentalsController < ApplicationController
  def checkout 
    # find movie that customer wants to check out
    movie = Movie.find_by(id: params[:id])
    customer = Customer.find_by(id: params[:id])

    movie.rentals.create(customer_id: customer.id, movie_id: movie.id)

    # make check out date to today
    movie.checkout_date = Time.now
    # make due date in one week from check out date
    movie.due_date = movie.checkout_date + (7*24*60*60)
    
    # reduce inventory/available count -1
  end 
end
