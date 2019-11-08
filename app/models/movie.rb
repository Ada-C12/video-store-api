class Movie < ApplicationRecord
  has_many :rentals, dependent: :nullify
  validates :title,  presence: true
  validates :inventory, presence: true, numericality: {greater_than: 0}

  def self.check_out(id)
    movie = Movie.find_by(id: id)
    if movie.available_inventory.nil?
      movie.available_inventory = movie.inventory
      movie.available_inventory -= 1
      movie.save
      return movie
    else
      movie.available_inventory -= 1
      movie.save
      return movie
    end
  end
end
