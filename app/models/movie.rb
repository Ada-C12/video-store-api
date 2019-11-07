require 'date'
require 'pry'

class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy
  has_many :customers, through: :rentals
  
  validates :title, presence: true
  validates :inventory, presence: true
  
  def movie_checkout
    checkout_movie = Movie.find_by(id: self.id)
    if checkout_movie != nil && checkout_movie.available_inventory >= 1
      checkout_movie.available_inventory -= 1
      return checkout_movie
    elsif checkout_movie.available_inventory < 1
      #render json: {"errors"=>["no inventory available"]}, status: :bad_request
      return checkout_movie
    else
      #render json: {"errors"=>["movie does not exist"]}, status: :not_found
      return checkout_movie
    end
  end
  
  def movie_checkin
    checkin_movie = Movie.find_by(id: self.id)
    if checkin_movie != nil 
      checkin_movie.available_inventory += 1
      return checkin_movie
    else
      render json: {"errors"=>["movie does not exist"]}, status: :not_found
      return 
    end
  end
end
