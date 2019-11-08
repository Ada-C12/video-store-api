class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  
  def check_out_rental
    self.movie.available_inventory -= 1
    self.movie.save
    self.customer.movies_checked_out_count += 1
    self.customer.save
  end
  
  def check_in_rental
    self.movie.available_inventory += 1
    self.movie.save
    self.customer.movies_checked_out_count -= 1
    self.customer.save
    self.returned = true
    self.save
  end
  
  def self.overdue
    return Rental.where("due_date < ? and returned = ?", Date.today, false)
  end
  
  def self.group_by_n(sort_type, n, page)
    if sort_type
      rentals = Rental.sort_by_type(sort_type).to_a
    else
      rentals = Rental.all.to_a
    end
    
    if n
      groups_of_rentals = []
      iterations = (rentals.count)/n.to_i
      
      iterations.times do
        groups_of_rentals << rentals.shift(n.to_i)
      end
      
      groups_of_rentals << rentals unless rentals.empty?
      
      groups_of_rentals = groups_of_rentals[page.to_i - 1] if page
      
      return groups_of_rentals
    else 
      return rentals
    end
  end
  
  def self.sort_by_type(sort_type)
    sort_type = sort_type.to_sym
    return Rental.order(sort_type => :asc)
  end
end
