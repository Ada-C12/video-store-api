class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  # validates :checkout_date, presence: true
  validates :due_date, presence: true

  def checkout_movie
    self.checkout_date = Time.now
    self.due_date = Time.now + 7
    self.movie.inventory -= 1
    self.customer.movies_checked_out_count += 1
    return
  end

  def checkin_movie
    self.movie.inventory += 1
    self.customer.movies_checked_out_count -= 1
    return
  end

  


end
