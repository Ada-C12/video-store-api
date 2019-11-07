class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals
  
  validates_presence_of :name
end
