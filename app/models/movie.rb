class Movie < ApplicationRecord
  has_and_belongs_to_many :customers

  validates :title, presence: true
  validates :overview, presence: true 
  validates :release_date, presence: true 
  validates :inventory, presence: true 
end
