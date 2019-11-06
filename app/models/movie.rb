class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy
  validates_format_of :release_date, with: /\d{4}-\d{2}-\d{2}/, on: [:create, :update], message: "Release Date Must Use Format YYYY-MM-DD"
end
