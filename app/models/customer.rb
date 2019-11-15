class Customer < ApplicationRecord
  has_many :rentals
  
  validates :name, :registered_at, :postal_code, :phone, presence: true
  
  #built-in validations done by rails: registered_at will be parsed into a type of DateTime to be accepted into DB
end
