class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  
  validates :customer_id, presence: true
  validates :movie_id, presence: true
  # validates :created_at, presence: true
  # validates :updated_at, presence: true
  
end
