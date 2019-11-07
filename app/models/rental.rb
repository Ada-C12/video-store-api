class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def setup_dates
    self.check_out = Date.today
    self.check_in = Date.today + 7
  end
end
