class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  validate :available
  
  def available
    if rental.movie.available_inventory == 0 
      errors.add(:availability, "can't check out a movie that is not in stock"
    else
      checkout
    end
  end

  def checkout 
    movie.available_inventory -= 1
    customer.movies_checked_out_count += 1
    @checkout_date = Date.now
    # make this work 
    @due_date = checkout_date + 7 
    self.save
  end

end
