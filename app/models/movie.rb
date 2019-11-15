require 'date'
require 'pry'

class Movie < ApplicationRecord
  after_initialize :set_default

  has_many :rentals, dependent: :destroy
  has_many :customers, through: :rentals
  
  validates :title, presence: true
  validates :inventory, presence: true
  
  def set_default
    if self.available_inventory.nil?
      self.available_inventory = self.inventory
    end
  end
end
