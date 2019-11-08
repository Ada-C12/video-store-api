class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  
  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true
  validates :available_inventory, presence: true

  def update_available_inventory(status)
    if status == "checkout"
      self.available_inventory -= 1 
    elsif status == "checkin"
      self.available_inventory += 1
    end 
  end 
end
