class Movie < ApplicationRecord

  has_many :rentals
  
  
  validates :title, :overview, :release_date, :inventory, :available_inventory, presence: true
  
  validates :inventory, :available_inventory, numericality: true
  
  validates_numericality_of :inventory, :available_inventory, greater_than_or_equal_to: 0
end
