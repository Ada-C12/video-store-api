class Movie < ApplicationRecord
  has_many :rentals
  validates :title, presence: true, uniqueness: true
  validates :inventory, presence: true


  def check_inventory
    if self.inventory > 0
      return true
    else
      return false
    end
  end

  
end
