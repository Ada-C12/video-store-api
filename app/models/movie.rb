class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true
  
  has_many :rentals
  
  def set_inventory
    if self.available_inventory.nil?
      self.available_inventory = self.inventory 
    end
    self.save
  end
  
  def decrease_inventory
    self.available_inventory -= 1
    self.save
  end
  
  def increase_inventory
    if !self.available_inventory
      self.available_inventory = self.inventory
    end
    self.available_inventory += 1
    self.save
  end
  
end
