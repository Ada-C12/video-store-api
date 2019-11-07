class Movie < ApplicationRecord
  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true
  
  has_many :rentals
  has_many :customers, through: :rentals
  
  def available_inventory
    return self.inventory
  end
end
