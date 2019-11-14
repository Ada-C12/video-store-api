class RentalsController < ApplicationController
  
  def checkout 
    rental = Rental.new(customer_id: params[:rental][:customer_id], movie_id: params[:rental][:movie_id], check_out_date: Date.today, due_date: (Date.today) + 7)
        
    if rental.save
      render json: rental.as_json(only: [:customer_id, :movie_id]), status: :ok
      return
    else
      # binding.pry
      render json: { ok: false, "errors" => ["Not Found"]}, status: :not_found
      return
    end
  end

  def checkin 
    rental = Rental.new(customer_id: params[:rental][:customer_id], movie_id: params[:rental][:movie_id], check_out_date: params[:rental][:check_out_date], due_date: params[:rental][:due_date], check_in_date: Date.today)

    if rental.save
      render json: rental.as_json(only: [:customer_id, :movie_id]), status: :ok 
      return
    else
      render json: { ok: false, "errors" => ["Not Found"]}, status: :not_found
      return
    end
  end
  
end
