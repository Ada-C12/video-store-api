class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  # validates :checkout_date, presence: true
  validates :due_date, presence: true

  # when POST /rentals/check-out controller action is hit
  # create a new instance of a rental
  # checkout_date is set to Time.now
  # due_date is set to 7 days from checkout_date
  # movie_id is passed in the request body
  # customer_id passed in the request body
  # once the rental is created, reduce the inventory of that movie 
  # by one.


  # Goal: we want to check inventory on a movie, if it's available, then create a rental
    # we need to pass in a movie_id and search the database for its record
    # return that movie, and look at its inventory count
    # if the inv < 1, throw an error or return false
    # if theres available inv, then 




  def checkout_movie
    rental.checkout_date = Time.now
    rental.due_date = Time.now + 7
    self.movie.inventory -= 1
    self.customer.movies_checked_out_count += 1
    return
  end

  


end
