class Rental < ApplicationRecord
  validates :checkout_date, presence: true
  validates :due_date, presence: true
  validates :movie_id, presence: true
  validates :customer_id, presence: true

  belongs_to :customer
  belongs_to :movie

  def initialize(params)
    super(params)
    self.checkout_date = Date.today
    self.due_date = Date.today + 7
  end
end