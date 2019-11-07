require 'date'
require 'pry'

class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy
  has_many :customers, through: :rentals
  
  validates :title, presence: true
  validates :inventory, presence: true
  
  def movie_checkout
    checkout_movie = Movie.find_by(id: self.id)
    if checkout_movie != nil
      puts checkout_movie
      puts checkout_movie.available_inventory
      if checkout_movie.available_inventory >= 1
        checkout_movie.available_inventory -= 1
        return 
      else
        render json: {"errors"=>["no inventory available"]}, status: :bad_request
        return
      end
    else
      render json: {"errors"=>["movie does not exist"]}, status: :not_found
      return
    end
  end
end
