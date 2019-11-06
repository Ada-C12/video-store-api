require 'date'

class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy
  has_many :customers, through: :rentals
  
  validates :title, presence: true
  validates :inventory, presence: true
end
