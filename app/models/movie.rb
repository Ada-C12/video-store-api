class Movie < ApplicationRecord
  has_many :rentals, dependent: :nullify
  has_many :customers, through: :rentals, dependent: :nullify
  after_initialize :set_available_inventory, only: [:save], if: :new_record?

  validates :title, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: -1 }


  def set_available_inventory
    if self.valid?
    self.available_inventory = self.inventory
    self.save!
    end
  end
end
