class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  
  validates_presence_of :title, :inventory 
end
