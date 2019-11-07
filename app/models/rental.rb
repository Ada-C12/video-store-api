class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  
  def decrease_available
    if self.movie.available_inventory.nil?
      self.movie.available_inventory = self.movie.inventory - 1
    else
      self.movie.available_inventory -= 1
    end
  end
  
  def increase_available
    self.movie.available_inventory += 1
  end
end
