class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  def check_out_rental
    self.movie.available_inventory -= 1
    self.customer.movies_checked_out_count += 1
  end
end
