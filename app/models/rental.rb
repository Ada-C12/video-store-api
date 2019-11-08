class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  
  validates :customer_id, presence: true 
  validates :movie_id, presence: true

  def self.find_customer(rental_params) 
    return Customer.find_by(id: rental_params[:customer_id])
  end 
  
  def self.find_movie(rental_params)
    return Movie.find_by(id: rental_params[:movie_id])
  end 
  
end
