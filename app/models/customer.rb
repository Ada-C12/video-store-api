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
    checkout_customer = self
    if checkout_customer != nil 
      checkout_customer.movies_checked_out_count += 1
      checkout_customer.save!
      # binding.pry
      return checkout_customer
    else
      render json: {"errors"=>["customer does not exist"]}, status: :not_found
      return
    end
  end
  
  def customer_checkin
    checkin_customer = self
    if checkin_customer != nil 
      checkin_customer.movies_checked_out_count -= 1
      checkin_customer.save!
      
      return checkin_customer
    else
      render json: {"errors"=>["customer does not exist"]}, status: :not_found
      return
    end
  end
end
