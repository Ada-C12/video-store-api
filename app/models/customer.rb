class Customer < ApplicationRecord
  has_many :rentals, dependent: :nullify
  has_many :movies, through: :rentals, dependent: :nullify

  validates :name, presence: true
end
