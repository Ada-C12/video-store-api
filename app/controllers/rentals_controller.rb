class RentalsController < ApplicationController
  
  def check_out
    ### CREATING a new rental record
    new_rental = Rental.new(rental_params)
    new_rental.checkout_date = Date.today
    new_rental.due_date = Date.today + 7.days
    new_rental.returned = false
    
    # does this movie (if existing) even have available_inventory?
    ### EMILY!!! Can we make this part of Rental model validations?  IDK if it's bad SRP practice...
    ### I think we'll have to look into custom model validations if we do that...
    movie = new_rental.movie
    if movie.nil? || movie.available_inventory <= 0
      render json: { errors: "Cannot make a rental because movie #{movie.title.capitalize} ran out of copies"}, status: :bad_request
      return
    end
    
    if new_rental.save
      this_rental = Rental.last
      movie.update(available_inventory: movie.available_inventory - 1)
      
      # update customer's checked_out_count
      customer = this_rental.customer
      customer.update(movies_checked_out_count: customer.movies_checked_out_count + 1)
      
      # prep API JSON
      render json: { msg: "Rental id #{this_rental.id}: #{this_rental.movie.title} due on #{this_rental.due_date}"}, status: :ok
      return
    else
      render json: { errors: "Cannot make a rental", error_msgs: new_rental.errors.full_messages }, status: :bad_request
      return
    end
    
  end
  
  def check_in
    rental = Rental.find_by(movie_id: rental_params[:movie_id].to_i, customer_id: rental_params[:customer_id].to_i)
    if rental.nil?
      render json: { errors: "Rental doesn't exist" }, status: :bad_request
      return 
    elsif rental.returned == true
      render json: { errors: "Rental has already been returned" }, status: :bad_request
      return
    else 
      rental.customer.update(movies_checked_out_count: rental.customer.movies_checked_out_count - 1)
      rental.movie.update(available_inventory: rental.movie.available_inventory + 1)
      rental.update(returned: true)
      render json: { msg: "Rental id #{rental.id}: #{rental.movie.title} has been returned." }, status: :ok
      return
    end 
  end
  
  def overdue
    possible_customers = Customer.where("movies_checked_out_count > ?", 0)
    overdue_customers = []
    
    possible_customers.each do |customer| 
      customer.rentals.each do |rental|
        unless rental.returned
          if rental.due_date.to_date < Date.today
            overdue_customers << customer
            # break out of this enumerable loop & move on to next customer
            break
          end
        end
      end
    end
    
    render json: overdue_customers, status: :ok
    return 
  end
  
  private
  
  def rental_params
    return params.permit(:movie_id, :customer_id)
  end
end
