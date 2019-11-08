class RentalsController < ApplicationController
  SORT_CATEGORIES = ["movie_id", "title", "customer_id", "name", "postal_code", "checkout_date", "due_date"]

  def create
    if params[:movie_id].nil? || params[:customer_id].nil?
      render json: { ok: false, "errors" => ["unable to create rental"]}, status: :bad_request
      return
    end
    
    rental = Rental.new(movie_id: params[:movie_id], customer_id: params[:customer_id])
    rental.checkout_date = Date.today
    rental.due_date = Date.today + 7 
    
    if rental.movie.available_inventory > 0 && rental.save
      rental.check_out_rental

      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, "errors" => ["unable to create rental"]}, status: :bad_request
      return
    end
  end
  
  def update
    rental = Rental.find_by(movie_id: params[:movie_id], customer_id: params[:customer_id])
    
    if rental
      rental.check_in_rental
      render json: rental.as_json(only: [:id]), status: :ok
      return
    else
      render json: { ok: false, "errors" => ["rental not found"]}, status: :not_found
      return
    end
  end
  
  def overdue
    if params[:sort] && SORT_CATEGORIES.include?(params[:sort]) == false
      render json: {ok: false, "errors" => ["invalid sort category"]}, status: :bad_request
      return
    end

    if params[:sort] || params[:n] || params[:p]
      rentals = Rental.overdue.group_by_n(params[:sort], params[:n], params[:p])

      if rentals == nil
        render json: {ok: false, "errors" => ["not found"]}, status: :not_found
        return
      end
    else
      rentals = Rental.overdue
    end

    render json: rentals.as_json(only: [:id, :movie_id, :title, :customer_id, :name, :postal_code, :checkout_date, :due_date]), status: :ok
    return
  end
  
end
