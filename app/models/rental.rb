class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def self.due_date(rental)
   due_date = Date.today + 7.days
   rental.due_date = due_date
   rental.save
   return rental
  end

  def self.status_checkout(rental)
    rental.status = "checked out"
    rental.save
    return rental
  end
end
