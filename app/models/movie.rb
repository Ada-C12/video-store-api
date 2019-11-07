class Movie < ApplicationRecord
  has_many :rentals, :dependent => :nullify
  
  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: {only_integer: true}
  
  def available_count
    if self.available_inventory.nil?
      self.available_inventory = self.inventory - self.rentals.where(checkin_date: nil)
    end
  end
end
