class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  
  def set_due_date
    self.due_date = self.checkout_date + 7
  end
end
