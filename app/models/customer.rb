class Customer < ApplicationRecord
  has_many :rentals
  
  def self.group_by_n(sort_type, n, page)
    if sort_type == "name"
      customers = Customer.sort_by_name.to_a
    elsif sort_type == "registered_at"
      customers = Customer.sort_by_registered_at.to_a
    elsif sort_type == "postal_code"
      customers = Customer.sort_by_postal_code.to_a
    else
      customers = Customer.all.to_a
    end
    
    if n
      iterations = (customers.count)/n.to_i
      groups_of_customers = []
      
      iterations.times do
        groups_of_customers << customers.shift(n.to_i)
      end
      
      groups_of_customers << customers
      
      #returns only one "page" of customers if page exists
      if page
        groups_of_customers = groups_of_customers[page.to_i - 1]
      end

      return groups_of_customers
    else 
      return customers
    end
  end
  
  def self.sort_by_name
    return Customer.order(name: :asc)
  end

  def self.sort_by_registered_at
    return Customer.order(registered_at: :asc)
  end

  def self.sort_by_postal_code
    return Customer.order(postal_code: :asc)
  end
end
