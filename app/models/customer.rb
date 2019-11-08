class Customer < ApplicationRecord
  has_many :rentals, dependent: :nullify
validates :name, presence: true
end
