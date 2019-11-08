class Customer < ApplicationRecord
  has_many :rentals
  validates :name, presence: true

  def self.check_out_movie(id)
    customer = Customer.find_by(id: id)
    movie_count = customer.movies_checked_out_count
    customer.update(movies_checked_out_count: movie_count + 1)

    # customer.movies_checked_out_count += 1
    customer.save
    return customer
  end

  def self.check_in_movie(customer)
    customer.movies_checked_out_count -= 1
    customer.save
    return customer
  end
end
