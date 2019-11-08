class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  validates :name, presence: true 
  validates :registered_at, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :movies_checked_out_count, presence: true

  def update_movies_checked_out(status)
    if status == "checkout"
      self.movies_checked_out_count += 1
    elsif status == "checkin"
      self.movies_checked_out_count -= 1 
    end 
  end 

end
