class Customer < ApplicationRecord
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :address, presence: true
  validates :phone, presence: true

  has_many :rentals, dependent: :nullify
  
end
