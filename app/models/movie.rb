class Movie < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :release_date, presence: true, format: {with: /\d{4}\W\d{2}\W\d{2}/}
  validates :inventory, presence: true, numericality: { only_integer: true }
end
