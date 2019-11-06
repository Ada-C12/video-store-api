class Customer < ApplicationRecord
  has_many :rentals
  
  def self.group_by_n(n, sort_type, page)
    if sort_type == "name"
      customers = Customer.sort_by_name.to_a
    else
      customers = Customer.all.to_a
    end
    
    if n
      iterations = (customers.count)/n.to_i
      result_array = []
      
      iterations.times do
        result_array << customers.shift(n.to_i)
      end
      
      result_array << customers
      # returns only one "page" of customers if :p exists
      if page
        result_array = result_array[page.to_i - 1]
      end
      return result_array
      
    else 
      return customers
    end
    
  end
  
  def self.sort_by_name
    return Customer.order(name: :asc)
  end
end
