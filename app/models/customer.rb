class Customer < ApplicationRecord
  has_many :rentals 
  has_many :movies, through: :rentals
  
  validates_presence_of :name
  validates :movies_checked_out_count, numericality: { greater_than_or_equal_to: 0 }
end
