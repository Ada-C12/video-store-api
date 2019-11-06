class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy
end