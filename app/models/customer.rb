class Customer < ApplicationRecord
  has_many :rentals

  def self.group_by_n(n, sort_type)
    if sort_type == "name"
      customers = Customer.sort_by_name.to_a
    else
      customers = Customer.all.to_a
    end

    iterations = (customers.count)/n.to_i
    result_array = []

    iterations.times do
      result_array << customers.shift(n.to_i)
    end

    result_array << customers
    return result_array
  end

  def self.sort_by_name
    return Customer.order(name: :asc)
  end
end
