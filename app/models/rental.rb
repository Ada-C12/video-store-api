class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  
  def setup_dates
    self.check_out = Date.today
    self.check_in = Date.today + 7
  end
  
  def rental_overdue
    if Date.today > self.check_in
      self.is_overdue = true 
      self.save
    end
  end
end
