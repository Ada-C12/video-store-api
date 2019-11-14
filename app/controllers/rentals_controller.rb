class RentalsController < ApplicationController
    
    def checkout
        
        # write helper method for defining variables and looking them up?
        customer_id = params[:customer_id]
        movie_id = params[:movie_id]
        
        customer = Customer.find_by(id: customer_id)
        movie = Movie.find_by(id: movie_id)
        
        if movie.nil? || customer.nil?
            render_error("Sorry, no record found for this movie or customer!")
            return
        end
        
        movies_available = movie.available_inventory 
        if movies_available > 0 && movies_available <= movie.inventory
            rental = Rental.create(customer_id: customer_id, movie_id: movie_id, due_date: Date.today + 7)
            movie.rentals << rental
            movies_available -= 1
            movie.save
            
            customer.rentals << rental
            customer.movies_checked_out_count += 1
            customer.save
        else
            render_error("Sorry, '#{movie.title}' has no copies available to rent")
            return
        end
        
        render json: movie, status: :ok
    end
    
    
    def checkin
        customer_id = params[:customer_id]
        movie_id = params[:movie_id]
        
        customer = Customer.find_by(id: customer_id)
        movie = Movie.find_by(id: movie_id)
        
        if movie.nil? || customer.nil?
            render_error("Sorry, no record found for this movie or customer!")
            return
        end
        
        movies_available = movie.available_inventory 
        if movies_available < movie.inventory
            rental = Rental.new(customer_id: customer_id, movie_id: movie_id)
            movie.rentals.delete(rental)
            movies_available += 1
            movie.save
            
            customer.rentals.delete(rental)
            customer.movies_checked_out_count -= 1
            customer.save
        else
            render_error("This movie is already fully stocked.")
            return
        end
        
        render json: movie, status: :ok
    end
    
    private 
    
    def rentals_params
        params.require(:rentals).permit(:customer_id, :movie_id, :due_date)
    end
    
    def render_error(message)
        render json: {
            ok: false,
            errors: message
            }, status: :bad_request
        end
    end
    
    
    