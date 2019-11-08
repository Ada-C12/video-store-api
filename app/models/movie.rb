class Movie < ApplicationRecord
  validates :title, uniqueness: true, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { greater_than_or_equal_to: 0, message: "must be greater than or equal to 0" }

  has_many :rentals
  has_many :customers, through: :rentals

  def initialize(params)
    super(params)
    self.available_inventory = self.inventory
  end
end
