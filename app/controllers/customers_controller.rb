class CustomersController < ApplicationController
  
  def index
    #needs movies_checked_out_count
    customers = Customer.all.as_json(only: [:id, :name, :registered_at, :postal_code, :phone])
    render json: customers, status: :ok
  end
  
end

