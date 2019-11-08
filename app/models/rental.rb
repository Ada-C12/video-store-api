class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  
  def self.check_out(customer, movie)
    if movie.available_inventory > 0
      rental = Rental.new
      rental.customer = customer
      rental.movie = movie
      rental.check_out = Date.today
      rental.due_date = rental.check_out + 7
      rental.save
      
      new_available_inventory = movie.available_inventory - 1
      movie.update(available_inventory: new_available_inventory)
      
      new_movies_checked_out_count = customer.movies_checked_out_count + 1
      customer.update(movies_checked_out_count: new_movies_checked_out_count)
      
      return rental
    end
    
    return nil
  end
  
  def self.check_in(rental)
    customer = rental.customer
    movie = rental.movie 
    
    customer.movies_checked_out_count -= 1
    movie.available_inventory += 1
    
    customer.save
    movie.save
  end
end
