class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates :due_date, presence: true

  def checkout_movie
    if self.movie.check_inventory == true
      self.movie.inventory -= 1
      self.customer.movies_checked_out_count += 1
      return
    end
  end

  def checkin_movie
    self.movie.inventory += 1
    self.customer.movies_checked_out_count -= 1
    return
  end

  


end
