class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  
  validates :checkout_date, :due_date, presence: true
  
  #built-in validations done by rails: checkout_date and due_date will be parsed into a type of Date to be accepted into DB
end
