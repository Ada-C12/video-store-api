require 'date'

class Customer < ApplicationRecord
  has_many :rentals, dependent: :destroy #Do we want this? Should it be nullify?
  has_many :movies, through: :rentals
  
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :registered_at, presence: true
  validates :phone, presence: true
  validates :movies_checked_out_count, presence: true
  
  def customer_checkout
    checkout_customer = Customer.find_by(id: self.id)
    if checkout_customer != nil 
      checkout_customer.movies_checked_out_count += 1
      return checkout_customer
    else
      render json: {"errors"=>["customer does not exist"]}, status: :not_found
      return
    end
  end
end
