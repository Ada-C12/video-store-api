class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates :checkout_date, presence: true
  validates :due_date, presence: true
end
