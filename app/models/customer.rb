require 'date'

class Customer < ApplicationRecord
  has_many :rentals, dependent: :destroy #Do we want this? Should it be nullify?
  has_many :movies, through: :rentals
  
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :registered_at, presence: true
  validates :phone, presence: true
  validates :movies_checked_out_count, presence: true
  
  # def checkout(customer)
  #   Checkout_Customer = Customer.find_by(customer.id)
  #   if Checkout_Customer == nil
  #     Customer.movies_checked_out_count += 1 
  #   else
  #     raise error
  #     render json: {"errors"=>["no inventory available"]}, status: :error
  #   end
  # end
end
