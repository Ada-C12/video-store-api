class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  validates :customer, presence: true
  validates :movie, presence: true
end
