require 'date'

class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals
  
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :registered_at, presence: true
end
