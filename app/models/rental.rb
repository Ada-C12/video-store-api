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
  # by one. -- maybe a model method?

end
