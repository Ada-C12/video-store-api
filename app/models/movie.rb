class Movie < ApplicationRecord
  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: true

  has_many :rentals

  before_create :set_available_inventory
  
  private

  def set_available_inventory
    self.available_inventory = self.inventory
  end
end
