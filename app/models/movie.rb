class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  
  validates :title, presence:true, uniqueness: true
  validates :inventory, numericality: { greater_than_or_equal_to: 0 }
end
