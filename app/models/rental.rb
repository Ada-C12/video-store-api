class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  validate :available
  
  def available
    if self.movie.available_inventory == 0 
      errors.add(:availability, "can't check out a movie that is not in stock")
    end
  end

  def checkout 
    self.movie.available_inventory -= 1
    self.customer.movies_checked_out_count += 1
    self.checkout_date = Date.today
    # make this work 
    self.due_date = self.checkout_date + 7 

    return self.save
  end

end
