class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  
  validates :customer_id, presence: true 
  validades :movie_id, presence: true
end
