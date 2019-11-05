class Movie < ApplicationRecord
  has_many :rentals, dependent: :nullify
end
