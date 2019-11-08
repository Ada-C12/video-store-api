class Movie < ApplicationRecord
  has_many :rentals
  
  validates :title, presence: true
  validates :title, uniqueness: true
end


t.string "title"
t.string "overview"
t.date "release_date"
t.integer "inventory"
t.integer "available_inventory"