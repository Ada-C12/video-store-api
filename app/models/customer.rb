class Customer < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  
  has_many :rentals
  
  def increase_movies_checkout
    self.movies_checked_out_count += 1
    self.save
  end

  def decrease_movies_checkout
    self.movies_checked_out_count -= 1
    self.save
  end
end
