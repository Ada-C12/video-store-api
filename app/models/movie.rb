require 'date'

class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy
  has_many :customers, through: :rentals
  
  validates :title, presence: true
  validates :inventory, presence: true
  
  def checkout(movie)
    Checkout_Movie = Movie.find_by(movie.id)
    if Checkout_Movie.available_inventory > 1
      Checkout_Movie.available_inventory -= 1 
    else
      raise error
      render json: {"errors"=>["no inventory available"]}, status: :error
    end
  end
end
