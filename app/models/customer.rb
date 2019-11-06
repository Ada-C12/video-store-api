class Customer < ApplicationRecord
  has_many :rentals, :dependent => :nullify
  
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  
end
