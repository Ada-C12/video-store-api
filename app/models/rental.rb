class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  
  def checkout_dates
    self.checkout_date = DateTime.now
    self.due_date = self.checkout_date + 7
  end
  
  def check_in
    self.due_date = nil
  end
  
end
