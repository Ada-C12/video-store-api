class Movie < ApplicationRecord
  has_many :rentals, dependent: :nullify
  has_many :customers, through: :rentals, dependent: :nullify

  validates :title, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: -1 }
  after_initialize :set_available_inventory, only: [:create]

  def set_available_inventory
    self.available_inventory = self.inventory
    self.save!
  end
end
