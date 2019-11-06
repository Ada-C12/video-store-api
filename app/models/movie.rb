class Movie < ApplicationRecord
  has_many :rentals
  validates :title,  presence: true
  validates :inventory, presence: true, numericality: {greater_than: 0}
end
